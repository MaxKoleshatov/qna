# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_answer, only: %i[show destroy]
  after_action :publish_answer, only: %i[create]

  include Voted

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.user = current_user

    if current_user.author?(@answer)

      @answer.update(answer_params)
      @question = @answer.question
    end
  end

  def destroy
    @answer.delete if current_user.author?(@answer)
  end

  def set_as_the_best
    @answer = Answer.find(params[:id])
    @question = @answer.question

    @answer.best_answer if current_user.author?(@question)
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def publish_answer
    ActionCable.server.broadcast(
      "questions/#{params[:question_id]}/answers", {
        partial: ApplicationController.render(
          partial: 'answers/answeruser',
          locals: { answer: @answer},
          assigns: { comment: Comment.new }
        ),
        answer: @answer
      }
    )
  end

  def answer_params
    params.require(:answer).permit(:text, files: [], links_attributes: %i[id name url])
  end
end

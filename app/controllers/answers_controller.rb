# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_answer, only: %i[show destroy]

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

  def answer_params
    params.require(:answer).permit(:text, files: [], links_attributes: %i[id name url])
  end
end

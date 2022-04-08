# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_answer, only: %i[show destroy]

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
    if current_user.author?(@answer)
      @answer.delete
    end
  end

  def set_as_the_best
    @answer = Answer.find(params[:id])
    @question = @answer.question
    
    @answer.best_answer if current_user.author?(@question)
    # @answer.add_prize
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:text, files: [], links_attributes: [:id, :name, :url])
  end
end

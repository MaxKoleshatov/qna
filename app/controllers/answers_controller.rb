# frozen_string_literal: true

class AnswersController < ApplicationController

  before_action :find_answer, only: %i[show destroy]
  before_action :authenticate_user!, except: [:show]

  def show; end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save

      redirect_to @answer, notice: 'Yes, you create new answer'
    else 
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question), notice: 'Yes, you delete answer'
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:text)
  end
end

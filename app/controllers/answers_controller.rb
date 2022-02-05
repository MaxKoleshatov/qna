# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    if @answer.save

      redirect_to @answer
    else render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :question_id)
  end
end

# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy]
  after_action :publish_question, only: %i[create]

  include Voted

  def index
    @questions = Question.all
   
  end

  def show
    @answer = Answer.new
    @answer.links.new
    @comment = Comment.new

    gon.push({
      current_user: current_user,
      question_id: @question.id
    })  
  end

  def new
    @question = Question.new
    @question.links.new
    @question.build_prize
  end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Yes, you create new question'
    else
      render :new
    end
  end

  def update
    @question.user = current_user

    @question.update(question_params) if current_user.author?(@question)
  end

  def destroy
    if current_user.author?(@question)
      @question.destroy
      redirect_to questions_path, notice: 'Yes, you delete question'
    else
      redirect_to @question
    end
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?
    
    ActionCable.server.broadcast(
      'questions', {
        partial: ApplicationController.render(
          partial: 'questions/questionuser',
          locals: { question: @question, current_user: current_user }
        ),
        question: @question
      }
    )
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: %i[id name url],
                                                    prize_attributes: %i[id name image])
  end
end

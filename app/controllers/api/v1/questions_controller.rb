# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      before_action :all_questions, only: %i[index]
      before_action :load_question, only: %i[show edit update destroy]

      authorize_resource

      def index
        render json: @questions
      end

      def show
        render json: @question, serializer: QuestionDataSerializer
      end

      def create
        if can?(:create, @question)
          @question = current_user.questions.new(question_params)
          redirect_to @question if @question.save
        end
      end

      def update
        @question.update(question_params) if can?(:update, @question)
      end

      def destroy
        @question.destroy if can?(:destroy, @question)
      end

      private

      def load_question
        @question = Question.with_attached_files.find(params[:id])
      end

      def all_questions
        @questions = Question.all
      end

      def question_params
        params.require(:question).permit(:title, :body)
      end
    end
  end
end

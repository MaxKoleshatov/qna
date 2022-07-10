class Api::V1::AnswersController < Api::V1::BaseController

    before_action :load_question, only: %i[index]
    before_action :load_answer, only: %i[show update destroy]

    authorize_resource

    def index
      @answers = @question.answers
      render json: @answers
    end

    def show
      render json: @answer, serializer: AnswerDataSerializer
    end

    def create
      @question = Question.find(params[:question_id])

      if can?(:create, @answer)
        @answer = @question.answers.new(answer_params)
        @answer.user = current_user
        @answer.save
      end
    end

    def destroy
      if can?(:destroy, @answer)
        @answer.delete
      end
    end

    def update
      if can?(:update, @answer)
        @answer.update(answer_params)
        @answer.save      
      end
    end

      private

    def load_answer
      @answer = Answer.find(params[:id])
    end

    def load_question
      @question = Question.with_attached_files.find(params[:question_id]) if params[:question_id]
    end

    def answer_params
      params.require(:answer).permit(:text)
    end
end

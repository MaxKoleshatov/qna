class CommentsController < ApplicationController

  after_action :publish_comment, only: %i[create]

  authorize_resource
  
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy if can?(:update, @comment)
    end

    def create
      @commentable = Answer.find_by(id: params[:answer_id]) || Question.find_by(id: params[:question_id])
      @comment = @commentable.comments.new(comment_params.merge(user: current_user))
      @comment.save
    end

    def comment_params
      params.require(:comment).permit(:text)
    end

    def publish_comment
      ActionCable.server.broadcast(
        "comments-#{channel.id}", {
          partial: ApplicationController.render(
            partial: 'comments/commentuser',
            locals: { comment: @comment}
          ),
          comment: @comment
        }
      )
    end

    def channel
      @comment.commentable_type.to_sym == :Answer ? @comment.commentable.question : @comment.commentable
    end
  end
    
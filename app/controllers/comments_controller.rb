class CommentsController < ApplicationController

  after_action :publish_comment, only: %i[create]
  
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy if current_user.author?(@comment.commentable)
    end

    def create
    @commentable = Answer.find_by(id: params[:answer_id]) || Question.find_by(id: params[:question_id])
    @comment = @commentable.comments.create(comment_params)
    @comment.save
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def publish_comment
    ActionCable.server.broadcast(
      'comments', {
        partial: ApplicationController.render(
          partial: 'comments/comment',
          locals: { comment: @comment}
        ),
        comment: @comment
      }
    )
  end
end
  
import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "CommentsChannel", question_id: gon.question_id}, {
    connected() {
        return this.perform("follow")
    },
    received: (data) => {
      const {comment} = data;
      const type = comment.commentable_type.toLowerCase();
      const id = comment.commentable_id
      const findcomment = "comment-" + id

      if (type === 'question' && comment.user_id !== gon.current_user.id) 
        {$('.comments_question').append(data.partial)} 
      else if (type === 'answer' && comment.user_id !== gon.current_user.id) 
        {$(document.getElementsByClassName(findcomment)).append(data.partial)}
                    
      $('.comment-new #comment_text').val('');
    }
});

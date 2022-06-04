import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "CommentsChannel"}, {
    connected() {
        return this.perform("follow")
        // console.log("CONNECTED commmet")
    },
    received: (data) => {

        const {comment} = data;

        const type = comment.commentable_type.toLowerCase();

        const id = comment.commentable_id

        const findcomment = "comment-" + id

        if (type === 'question') {
            $('.comments_question').append(data.partial);
        } else {
            $(document.getElementsByClassName(findcomment)).append(data.partial);
        }
                    
        $('.comment-new #comment_text').val('');
    }
});

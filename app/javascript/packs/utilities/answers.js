// import answerTemplate from '../../templates/answer.jst.skim';
import consumer from "channels/consumer"

$(document).on('turbolinks:load', function(){
    $('.answers').on('click', '.edit-answer-link', function(e) {
        e.preventDefault();
        $(this).hide();
        var answerId = $(this).data('answerId');
        console.log(answerId);
        $('form#edit-answer-' + answerId).removeClass('hidden');
    })
 });

 consumer.subscriptions.create({ channel: "AnswersChannel"}, {
    connected() {
        // console.log("Ответы")
        return this.perform("follow")
    },
    received: (data) => {
      $('.answers').append(data.partial);
      $('.answer-new #answer_text').val('');
    }
});
 
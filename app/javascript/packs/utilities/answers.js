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

 consumer.subscriptions.create({ channel: "AnswersChannel", question_id: gon.question_id }, {
    connected() {
      return this.perform("follow")
    },
    received: (data) => {
      const {answer} = data;

      if (answer.user_id !== gon.current_user.id) 
      {$('.answers').append(data.partial)} 
      $('.answer-new #answer_text').val('');
    }
    
});
 
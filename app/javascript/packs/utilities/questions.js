// import questionTemplate from '../../templates/question.hbs';
import consumer from "channels/consumer"

$(document).on('turbolinks:load', function(){
    $('.questions').on('click', '.edit-question-link', function(e) {
        e.preventDefault();
        $(this).hide();
        var questionId = $(this).data('questionId');
        console.log(questionId);
        $('form#edit-question-' + questionId).removeClass('hidden');
    })
});

consumer.subscriptions.create('QuestionsChannel', {
    connected() {

     return this.perform("follow")
    },
     
    received: (data) =>{
         $('.questions').append(data.partial)
    }
});
 
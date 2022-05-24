$(document).on('turbolinks:load',() => {
    $('.up').on('ajax:success', (e) => {
      const [vote] = e.detail;
      $(document.getElementById("counter-" + vote.id)).text(vote.value);
    })

    $('.down').on('ajax:success', (e) => {
      const [vote] = e.detail;
      $(document.getElementById("counter-" + vote.id)).text(vote.value);
    })

    $('.delete').on('ajax:success', (e) => {
      const [vote] = e.detail;
      $(document.getElementById("counter-" + vote.id)).text(vote.value);
    })
 });
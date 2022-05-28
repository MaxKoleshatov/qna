$(document).on('turbolinks:load',() => {
    $('.up').on('ajax:success', (e) => {
      const [vote] = e.detail;
      $(document.getElementById("counter-progress")).text(vote.progress);
    })

    $('.down').on('ajax:success', (e) => {
      const [vote] = e.detail;
      $(document.getElementById("counter-progress")).text(vote.progress);
    })

    $('.delete').on('ajax:success', (e) => {
      const [vote] = e.detail;
      $(document.getElementById("counter-progress")).text(vote.progress);
    })
 });
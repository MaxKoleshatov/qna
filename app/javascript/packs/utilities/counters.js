$(document).on('turbolinks:load',() => {
     
    $('.up').on('ajax:success', (e) => {
      const [vote] = e.detail;
      const id = vote.id;
      findcounter = "counter-progress-" + id;
      $(document.getElementById(findcounter)).text(vote.progress);
    })

    $('.down').on('ajax:success', (e) => {
      const [vote] = e.detail;
      const id = vote.id;
      findcounter = "counter-progress-" + id;
      $(document.getElementById(findcounter)).text(vote.progress);
    })

    $('.delete').on('ajax:success', (e) => {
      const [vote] = e.detail;
      const id = vote.id;
      findcounter = "counter-progress-" + id;
      $(document.getElementById(findcounter)).text(vote.progress);
    })

   
 });
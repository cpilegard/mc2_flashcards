$(document).ready(function() {
  $('#answer_form').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: this.action,
      type: this.method,
      data: $('#answer_form').serialize()
    }).done(function(answer){
      $('#message').text(answer);
      $('#submit_guess').hide();
      $('#answer_checked').slideDown();
    });
  });
});

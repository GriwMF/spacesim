import $ from 'jquery'

$(document).ready(function () {
  $('#sub-button').click(function (e) {
    e.preventDefault();
    let email = $('input[name=email]').val();
    let token = $('input[name=authenticity_token]').val();
    let path = window.location.pathname;
    if (path === '/') {
      path = ''
    }
    $.post(path + '/subscription', { email: email, authenticity_token: token } )
      .done(function(data) {
        $('#subscribe').html(data.message);
      })
      .fail(function(data) {
        $('.errors').html(data.responseJSON.message);
      })
  })
})

//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  $('#loading-btn').click(function () {
    var btn = $(this)
    btn.button('loading')
    $.ajax(btn.data('url'), {
      type: 'GET'
    }).always(function () {
      btn.button('reset')
      location.reload();
    });
  });
});

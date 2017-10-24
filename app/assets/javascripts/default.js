$(function(){
  // Dismiss alert messages
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  // Initialize select inputs
  $('select').dropdown();
});

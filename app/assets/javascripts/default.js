$(document).on('turbolinks:load', function(){
  // Dismiss alert messages
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  // Initialize accordions
  $('.ui.accordion').accordion();

  // Initialize modals
  $('.ui.modal').modal({
    onApprove: function () {
      return false
    }
  });

  // Initialize select inputs
  $('select').dropdown();

  // Initialize special cards
  $('.special.cards .pricing-option').dimmer({
    on: 'hover'
  });

  // Tooltips
  $('[data-content], [data-title]').popup();
});

$(function() {
  window.CheckOut = (function() {
    var initialize = function() {
      checkIn();
      checkOut();
    }
    
    function checkIn() {
      $('.resource').on('click', '.check-in', function() {
        var button = $(this);
        var id = button.parent('.resource').data('id');
        var url = '/resources/' + id + '/check-in';

        $.post(url, function(data) {
          button.addClass('check-out');
          button.removeClass('check-in');
          button.text('Check Out');
        });
      });
    }

    function checkOut() {
      $('.resource').on('click', '.check-out', function() {
        var button = $(this);
        var id = button.parent('.resource').data('id');
        var user_id = button.siblings('.user-name').val();
        var url = '/resources/' + id + '/check-out';

        $.post(url, { user_id: user_id }, function(data) {
          button.addClass('check-in');
          button.removeClass('check-out');
          button.text('Check In');
        });
      });
    }
    
    return {
      initialize: initialize
    };
  })();
  
  window.CheckOut.initialize();
});

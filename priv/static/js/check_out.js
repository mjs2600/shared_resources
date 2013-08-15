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

        console.log(url);

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
        var url = '/resources/' + id + '/check-out';

        console.log(url);

        $.post('/resources/5/check-out', function(data) {
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
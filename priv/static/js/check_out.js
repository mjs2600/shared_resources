$(function() {
  window.CheckOut = (function() {
    var initialize = function() {
      checkIn();
      checkOut();
    }
    
    function checkIn() {
      $('.check-in').click(function() {
        $.post('/check-in/5', function(data) {
          console.log(data);
          console.log(this);
        });
      });
    }

    function checkOut() {
      $('.check-out').click(function() {
        $.post('/check-out/5', function(data) {
          console.log(data);
          console.log(this);
        });
      });
    }
    
    return {
      initialize: initialize
    };
  })();
  
  window.CheckOut.initialize();
});
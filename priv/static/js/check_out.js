$(function() {
  window.CheckOut = (function() {
    var initialize = function() {
      checkOutListener();
    }

    function renderCheckOut(resource) {
      var button = resource.find("a");
      button.addClass('check-in');
      button.removeClass('check-out');
      button.text('Check In');
      resource.find(".location").hide();
      resource.find(".user-name").hide();
      resource.data('checked-out', "true");
    }

    function renderCheckIn(resource) {
      var button = resource.find("a");
      button.addClass('check-out');
      button.removeClass('check-in');
      button.text('Check Out');
      resource.find(".location").hide();
      resource.find(".user-name").show();
      resource.data('checked-out', "false");
    }

    function checkOutListener() {
      $('.resource').on('click', '.checkout', function() {
        var button = $(this);
        var resource = button.parent('.resource')
        var id = resource.data('id');
        var user_id = button.siblings('.user-name').val();
        var checkedOut = resource.data('checked-out') === "true"
        var route = checkedOut ? "check-in" : "check-out"
        var url = '/resources/' + id + '/' + route;

        $.post(url, { user_id: user_id }, function(data) {
          if (checkedOut) {
            renderCheckIn(resource);
          }else {
            renderCheckOut(resource);
          }
        });
      });
    }

    return {
      initialize: initialize
    };
  })();

  window.CheckOut.initialize();
});

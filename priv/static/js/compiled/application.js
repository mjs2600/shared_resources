// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    return window.Checkout = (function() {
      var checkoutItem, createStreams, foo, initialize, transformText;
      initialize = function() {
        return createStreams();
      };
      createStreams = function() {
        var checkoutElem, checkoutStream, targetStream;
        checkoutElem = $('.resource').find('.checkout');
        checkoutStream = checkoutElem.asEventStream('click');
        targetStream = checkoutStream.map(function(event) {
          return event.target;
        });
        return targetStream.onValue(checkoutItem);
      };
      checkoutItem = function(target) {
        var action, resource, responseStream, userId;
        resource = $(target).closest('.resource');
        userId = resource.find('.user-name').val();
        action = resource.find('.checkout');
        responseStream = Bacon.fromPromise($.post("/resources/" + (resource.data('id')) + "/check-out", {
          user_id: userId
        }));
        return foo(responseStream, target);
      };
      foo = function(stream, target) {
        var _this = this;
        this.target = target;
        return stream.onValue(function(response, target) {
          return transformText(response, _this.target);
        });
      };
      transformText = function(response, target) {
        return $(target).closest('.location').text(response.action_text);
      };
      return initialize();
    })();
  });

}).call(this);

// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    window.SharedResources || (window.SharedResources = {});
    SharedResources.newCheckout = function() {
      var action, changeInterface, checkoutItem, createStreams, initializeTextTransformer, toggleUserMenu, transformActionClass, transformActionText, transformResourceData, transformStatusMessage;
      createStreams = function() {
        var checkoutElem, checkoutStream;
        checkoutElem = $('.resource').find('.checkout');
        checkoutStream = checkoutElem.asEventStream('click');
        return this.initializeTextTransformer(checkoutStream);
      };
      initializeTextTransformer = function(checkoutStream) {
        var targetStream;
        targetStream = checkoutStream.map(function(event) {
          return event.target;
        });
        return targetStream.onValue(checkoutItem);
      };
      checkoutItem = function(target) {
        var checkedOut, path, resource, responseStream;
        resource = $(target).closest('.resource');
        checkedOut = resource.data('checked-out');
        path = "/resources/" + (resource.data('id')) + "/" + (action(checkedOut));
        responseStream = Bacon.fromPromise($.post(path));
        return changeInterface(responseStream, target);
      };
      changeInterface = function(stream, target) {
        var _this = this;
        this.target = $(target);
        return stream.onValue(function(response) {
          var responseObject;
          responseObject = JSON.parse(response);
          transformActionText(responseObject.action_text, _this.target);
          transformActionClass(responseObject.action_classes, _this.target);
          transformResourceData(responseObject.checked_out, _this.target);
          transformStatusMessage(responseObject.status_message, _this.target);
          return toggleUserMenu(_this.target);
        });
      };
      transformActionText = function(actionText, $target) {
        return $target.text(actionText);
      };
      transformActionClass = function(action_classes, $target) {
        $target.toggleClass(action_classes[0]);
        return $target.toggleClass(action_classes[1]);
      };
      transformResourceData = function(checkedOut, $target) {
        return $target.closest('.resource').data('checked-out', checkedOut);
      };
      transformStatusMessage = function(message, $target) {
        return $target.siblings('.location').text(message);
      };
      toggleUserMenu = function($target) {
        return $target.siblings('.user-name').toggle();
      };
      action = function(checkedOut) {
        var route;
        if (checkedOut) {
          route = 'check-in';
        } else {
          route = 'check-out';
        }
        return route;
      };
      return {
        createStreams: createStreams,
        initializeTextTransformer: initializeTextTransformer,
        checkoutItem: checkoutItem,
        changeInterface: changeInterface,
        transformActionText: transformActionText,
        transformActionClass: transformActionClass,
        transformResourceData: transformResourceData,
        transformStatusMessage: transformStatusMessage,
        toggleUserMenu: toggleUserMenu,
        action: action
      };
    };
    SharedResources.Checkout = SharedResources.newCheckout();
    return SharedResources.Checkout.createStreams();
  });

  $(function() {
    window.SharedResources || (window.SharedResources = {});
    SharedResources["delete"] = function() {
      var createStreams, deleteItem;
      createStreams = function() {
        var deleteElem, deleteStream;
        deleteElem = $('.resource').find('.delete');
        deleteStream = deleteElem.asEventStream('click');
        return deleteStream.map(function(e) {
          return this.deleteItem(e.target);
        });
      };
      deleteItem = function(target) {
        var path, resource, responseStream;
        resource = $(target).closest('.resource');
        path = "/resources/" + (resource.data('id')) + "/delete";
        responseStream = Bacon.fromPromise($.post(path));
        return resource.fadeOut(3000);
      };
      return {
        createStreams: createStreams
      };
    };
    SharedResources.Delete = SharedResources["delete"]();
    return SharedResources.Delete.createStreams();
  });

  $(function() {
    if ($('#errors').text() === "") {
      $('#errors').hide();
    }
    if ($('#notices').text() === "") {
      $('#notices').hide();
    }
    return $('.notice_section').delay(4000).slideUp(1000);
  });

}).call(this);

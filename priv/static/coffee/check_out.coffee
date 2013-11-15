$ ->
  window.SharedResources ||= {}

  SharedResources.Checkout = do ->
    createStreams = ->
      checkoutElem = $('.resource').find('.checkout')
      checkoutStream = checkoutElem.asEventStream('click')
      initializeTextTransformer(checkoutStream)

    initializeTextTransformer = (checkoutStream) ->
      targetStream = checkoutStream.map((event) -> event.target)
      targetStream.onValue checkoutItem

    checkoutItem = (target) ->
      resource = $(target).closest('.resource')
      userId = resource.find('.user-name').val()
      checkedOut = resource.data('checked-out')
      path = "/resources/#{resource.data('id')}/#{action(checkedOut)}"
      responseStream = Bacon.fromPromise($.post(path, {user_id: userId}))
      changeInterface(responseStream, target)

    changeInterface = (stream, target) ->
      @target = $(target)
      stream.onValue (response) =>
        responseObject = JSON.parse(response)
        transformActionText(responseObject.action_text, @target)
        transformActionClass(responseObject.action_classes, @target)
        transformResourceData(responseObject.checked_out, @target)
        transformStatusMessage(responseObject.status_message, @target)
        toggleUserMenu(@target)

    transformActionText = (actionText, $target) ->
      $target.text(actionText)

    transformActionClass = (action_classes, $target) ->
      $target.toggleClass action_classes[0]
      $target.toggleClass action_classes[1]

    transformResourceData = (checkedOut, $target) ->
      $target.closest('.resource').data('checked-out', checkedOut)

    transformStatusMessage = (message, $target) ->
      $target.siblings('.location').text(message)

    toggleUserMenu = ($target) ->
      $target.siblings('.user-name').toggle()

    action = (checkedOut) ->
      if checkedOut
        route = 'check-in'
      else
        route = 'check-out'

      route

    createStreams: createStreams

  SharedResources.Checkout.createStreams()

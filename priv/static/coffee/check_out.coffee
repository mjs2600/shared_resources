$ ->
  window.SharedResources ||= {}

  SharedResources.newCheckout = ->
    createStreams = ->
      checkoutElem = $('.resource').find('.checkout')
      checkoutStream = checkoutElem.asEventStream('click')
      @initializeTextTransformer(checkoutStream)

    initializeTextTransformer = (checkoutStream) ->
      targetStream = checkoutStream.map((event) -> event.target)
      targetStream.onValue checkoutItem

    checkoutItem = (target) ->
      resource = $(target).closest('.resource')
      checkedOut = resource.data('checked-out')
      userId = resource.find('select[name=user_id]').val()
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
        toggleCheckerSelector(@target)

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

    toggleCheckerSelector = ($target) ->
      $target.siblings('select[name=user_id]').toggle()

    action = (checkedOut) ->
      if checkedOut
        route = 'check-in'
      else
        route = 'check-out'

      route

    {
      createStreams: createStreams
      initializeTextTransformer: initializeTextTransformer
      checkoutItem: checkoutItem
      changeInterface: changeInterface
      transformActionText: transformActionText
      transformActionClass: transformActionClass
      transformResourceData: transformResourceData
      transformStatusMessage: transformStatusMessage
      toggleUserMenu: toggleUserMenu
      action: action
    }

  SharedResources.Checkout = SharedResources.newCheckout()
  SharedResources.Checkout.createStreams()

$ ->
  window.Checkout = do ->

    initialize = ->
      createStreams()

    createStreams = ->
      checkoutElem = $('.resource').find('.checkout')
      checkoutStream = checkoutElem.asEventStream('click')
      targetStream = checkoutStream.map((event) -> event.target)
      targetStream.onValue checkoutItem

    checkoutItem = (target) ->
      resource = $(target).closest('.resource')
      userId = resource.find('.user-name').val()
      # Do something to pull the last class off the element below
      action = resource.find('.checkout')
      # Don't check out all the time. Change the URL.
      responseStream = Bacon.fromPromise($.post("/resources/#{resource.data('id')}/check-out", {user_id: userId}))
      # Rename foo
      foo(responseStream, target)

    foo = (stream, target) ->
      @target = target
      stream.onValue (response, target) =>
        transformText(response, @target)

    transformText = (response, target) ->
      $(target).closest('.location').text(response.action_text)
    
    initialize()

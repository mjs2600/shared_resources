$ ->
  window.Checkout = do ->

    initialize = ->
      createStreams()

    createStreams = ->
      resource = $('.resource')
      checkoutElem = $(resource).find('.checkout')
      checkoutStream = checkoutElem.asEventStream('click')
      initializeTextTransformer(checkoutStream)

    initializeTextTransformer = (checkoutStream) ->
      targetStream = checkoutStream.map((event) -> event.target)
      targetStream.onValue((target) -> updateText(target))

    updateText = (target) ->
      console.log 'Test'
    
    initialize()

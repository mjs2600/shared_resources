$ ->
  window.Checkout = do ->

    initialize = ->
      createStreams()

    createStreams = ->
      resource = $(".resource")
      checkoutElem = $(resource).find('.checkout')
      checkoutStream = checkoutElem.asEventStream('click')
      initializeTextTransformer(checkoutStream)

    initializeTextTransformer = (checkoutStream) ->
      checkoutStream.map((event) -> event.target).onValue((target) -> updateText(target))

    updateText = (target) -> console.log "HI"


    
    initialize()

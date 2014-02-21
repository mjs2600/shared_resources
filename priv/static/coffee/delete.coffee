$ ->
  window.SharedResources ||= {}

  SharedResources.delete = ->
    createStreams = ->
      deleteElem = $('.resource').find('.delete')
      deleteStream = deleteElem.asEventStream('click')
      deleteStream.onValue (e) -> deleteItem(e.target)

    deleteItem = (target) ->
      resource = $(target).closest('.resource')
      path = "/resources/#{resource.data('id')}/delete"
      if (confirm("Hey, you sure you want to remove that?"))
        responseStream = Bacon.fromPromise($.post(path))
        resource.fadeOut(500)

    {
      createStreams: createStreams
    }

  SharedResources.Delete = SharedResources.delete()
  SharedResources.Delete.createStreams()

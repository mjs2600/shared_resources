$ ->
  window.SharedResources ||= {}

  SharedResources.delete = ->
    createStreams = ->
      deleteElem = $('.resource').find('.delete')
      deleteStream = deleteElem.asEventStream('click')
      deleteStream.map (e) -> @deleteItem(e.target)

    deleteItem = (target) ->
      resource = $(target).closest('.resource')
      path = "/resources/#{resource.data('id')}/delete"
      responseStream = Bacon.fromPromise($.post(path))
      resource.fadeOut(3000)

    {
      createStreams: createStreams
    }

  SharedResources.Delete = SharedResources.delete()
  SharedResources.Delete.createStreams()

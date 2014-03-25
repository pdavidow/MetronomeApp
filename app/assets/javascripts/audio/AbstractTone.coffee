class window.AbstractTone

  startAtTime: (time) ->
    @source = @startBufferAtTime(time)
    @source.onended = @onEnded

  startBufferAtTime: (time) ->
    Audio.startBufferAtTime(@buffer(), time)

  onEnded: ->

  stop: ->
    @source?.disconnect()

  buffer: ->
    alert('subclass implementation')


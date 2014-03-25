class window.StartTriggerSilentTone extends window.SilentTone

  # Workaround for lack of AudioBufferSourceNode 'onstarted' callback in Web Audio API.

  constructor: (@trigger) ->

  startAtTime: (time) =>
    super(time - @duration)

  onEnded: =>
    @trigger()




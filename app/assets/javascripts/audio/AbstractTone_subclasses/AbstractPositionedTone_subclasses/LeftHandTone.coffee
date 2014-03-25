class window.LeftHandTone extends window.AbstractPositionedTone

  buffer: ->
    Audio.tone_900hz

  position: ->
    @positionLeft
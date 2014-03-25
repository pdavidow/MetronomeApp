class window.RightHandTone extends window.AbstractPositionedTone

  buffer: ->
    Audio.tone_1000hz

  position: ->
    @positionRight

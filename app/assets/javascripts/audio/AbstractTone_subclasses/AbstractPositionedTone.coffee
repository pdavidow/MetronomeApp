class window.AbstractPositionedTone extends window.AbstractTone

  constructor: (@isStereo) ->

  positionRight:  [+1,0,0]
  positionCenter: [ 0,0,0]
  positionLeft:   [-1,0,0]

  startBufferAtTime: (time) =>
    return super(time) unless @isStereo
    Audio.startBufferAtTimeAtPosition(@buffer(), time, @position())

  position: ->
    alert('subclass implementation')

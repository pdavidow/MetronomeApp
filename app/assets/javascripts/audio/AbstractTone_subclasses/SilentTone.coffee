class window.SilentTone extends window.AbstractTone

  duration: 0.001 # seconds

  buffer: ->
    Audio.tone_Silent_1ms



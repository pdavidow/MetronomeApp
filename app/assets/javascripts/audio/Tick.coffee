class window.Tick

  constructor: (@metronome, @beat, @data) ->
    @waitSeconds = @data.wait_seconds
    @tones = @makeTones()

  makeTones: ->
    tones = []
    tones.push(new BackgroundTone()) if @data.is_background
    tones.push(new ClassicTone()) if @data.is_classic
    tones.push(new RightHandTone(@metronome.isStereo)) if @data.is_right_hand
    tones.push(new LeftHandTone(@metronome.isStereo)) if @data.is_left_hand
    tones

  startAtTime: (time) ->
    each.startAtTime(time) for each in @tones

  stop: ->
    each.stop() for each in @tones






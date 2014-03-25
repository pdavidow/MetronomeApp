class window.Beat

  constructor: (@metronome, @data) ->
    @ticks = @makeTicks()

  makeTicks: () ->
    classForIndex = (i) -> if i is 0 then BeatFirstTick else Tick
    ((new (classForIndex(i))(@metronome, @, each)) for each,i in @data.ticks)

  onStarted: ->
    @metronome.setCurrentBeatTo(@)

  displayInfo: ->
    @data.display_location_description






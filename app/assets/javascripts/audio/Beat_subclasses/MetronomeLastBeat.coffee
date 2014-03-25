class window.MetronomeLastBeat extends window.Beat

  makeTicks: () =>
    ticks = super()
    ticks.push(new UtilityTick(@onEnded))
    ticks

  onEnded: =>
    @metronome.onEnded()

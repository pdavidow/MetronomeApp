class window.BeatFirstTick extends window.Tick

  makeTones: =>
    tones = super()
    tones.push(new StartTriggerSilentTone(@trigger))
    tones

  trigger: =>
    @beat.onStarted()





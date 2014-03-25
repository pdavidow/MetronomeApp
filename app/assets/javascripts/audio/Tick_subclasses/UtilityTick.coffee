class window.UtilityTick extends window.Tick

  constructor: (@onEnded) ->
    @waitSeconds = 0
    @tones = @makeTones()

  makeTones: =>
    [new StartTriggerSilentTone(@onEnded)]







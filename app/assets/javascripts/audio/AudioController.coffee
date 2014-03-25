class window.AudioController

  @finishedLoading: ->
    $(document).ready ->
      if gon?.users_show?
        metronome = new Metronome
        metronome.on('change:currentBeat', -> $('#chrome_logo').slideToggle())
        metronome.start()
        return
      if gon?.pieces_index?
        return Tunes.spectrumSweep()
      if gon?.is_enable_metronome_start?
        return (if gon.is_enable_metronome_start then Tunes.okay() else Tunes.notOkay())

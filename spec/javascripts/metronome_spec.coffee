# Assumes at least one user is persisted in 'development' db

describe "Metronome:", ->

  beforeEach ->
    window.onload = Audio.initializeSound_onFinishedLoading()

  it "displays for last beat in last measure, if that beat has more than 1 tick", ->
    loadFixtures "metronome_no_loop"
    metronome = new Metronome
    new MetronomeView(metronome)
    field = $('#current_beat')

    firstBeat = metronome.beats.first()
    firstBeat.onStarted()
    expect(field).toHaveText(firstBeat.displayInfo())
    lastBeat = metronome.beats.last()
    lastBeat.onStarted()
    expect(field).toHaveText(lastBeat.displayInfo())

  it "displays for last beat in last measure, if that beat only has 1 tick", ->
    loadFixtures "metronome_last_beat_in_last_measure_only_has_1_tick"
    metronome = new Metronome
    new MetronomeView(metronome)
    field = $('#current_beat')

    firstBeat = metronome.beats.first()
    firstBeat.onStarted()
    expect(field).toHaveText(firstBeat.displayInfo())
    lastBeat = metronome.beats.last()
    lastBeat.onStarted()
    expect(field).toHaveText(lastBeat.displayInfo())

  it "triggers 'started' when started", ->
    loadFixtures "metronome_no_loop"
    string = 'STARTED'
    metronomeStarted = -> field.text(string)
    spyOn(Tick.prototype, 'startAtTime')

    metronome = new Metronome
    metronome.on('started', metronomeStarted)
    new MetronomeView(metronome)
    field = $('#current_beat')

    firstBeat = metronome.beats.first()
    expect(field).toHaveText(firstBeat.displayInfo())
    metronome.start()
    expect(field).toHaveText(string)

  describe "Triggers 'stopped' when stopped:", ->
    it "manually", ->
      loadFixtures "metronome_no_loop"
      string = 'STOPPED'
      metronomeStopped = -> field.text(string)
      spyOn(Tick.prototype, 'startAtTime')
      spyOn(Tick.prototype, 'stop')

      metronome = new Metronome
      metronome.on('stopped', metronomeStopped)
      new MetronomeView(metronome)
      field = $('#current_beat')

      firstBeat = metronome.beats.first()
      expect(field).toHaveText(firstBeat.displayInfo())
      metronome.stop()
      expect(field).toHaveText(string)

    it "automatically", ->
      loadFixtures "metronome_no_loop"
      string = 'STOPPED'
      metronomeStopped = -> field.text(string)
      spyOn(Tick.prototype, 'startAtTime')
      spyOn(Tick.prototype, 'stop')

      metronome = new Metronome
      metronome.on('stopped', metronomeStopped)
      new MetronomeView(metronome)
      field = $('#current_beat')

      firstBeat = metronome.beats.first()
      firstBeat.onStarted()
      expect(field).toHaveText(firstBeat.displayInfo())
      lastBeat = metronome.beats.last()
      lastBeat.onEnded()
      expect(field).toHaveText(string)

  it "displays corresponding beat info for all beats", ->
    loadFixtures "metronome_no_loop"
    spyOn(Tick.prototype, 'startAtTime')

    metronome = new Metronome
    new MetronomeView(metronome)
    field = $('#current_beat')

    for beat in metronome.beats
      beat.onStarted()
      expect(field).toHaveText(beat.displayInfo())

    spyOn(metronome, 'setCurrentBeatTo')
    metronomeStopped = -> expect(metronome.setCurrentBeatTo.calls.count()).toEqual(metronome.beats.length)
    metronome.on('stopped', metronomeStopped)
    metronome.start()

  it "can loop (triggers 'looped' when restart)", ->
    loadFixtures "metronome_loop_entire"
    stopString = 'STOPPED'
    metronomeStopped = -> field.text(stopString)
    spyOn(Metronome.prototype, 'startAtTime')
    spyOn(AbstractTone.prototype, 'stop')

    metronome = new Metronome
    metronome.on('stopped', metronomeStopped)
    new MetronomeView(metronome)
    field = $('#current_beat')

    firstBeat = metronome.beats.first()
    expect(field).toHaveText(firstBeat.displayInfo())
    metronome.start()
    metronome.stop()
    expect(field).toHaveText(stopString)

    metronome = new Metronome
    lupe = false
    metronomeLooped = -> (lupe = true)
    metronome.on('looped', metronomeLooped)
    metronome.on('stopped', metronomeStopped)
    new MetronomeView(metronome)
    field = $('#current_beat')
    expect(metronome.isLoop).toBe(true)

    firstBeat = metronome.beats.first()
    firstBeat.onStarted()
    expect(field).toHaveText(firstBeat.displayInfo())

    lastBeat = metronome.beats.last()
    expect(lupe).toBe(false)
    lastBeat.onStarted()
    expect(lupe).toBe(false)
    expect(field).toHaveText(lastBeat.displayInfo())

    lastBeat.onEnded()
    expect(lupe).toBe(true)
    expect(field).toHaveText(lastBeat.displayInfo())

    firstBeat.onStarted()
    expect(field).toHaveText(firstBeat.displayInfo())

    metronome.stop()
    expect(field).toHaveText(stopString)

  it "has loop view which counts iterations", ->
    loadFixtures "metronome_loop_entire"
    spyOn(Metronome.prototype, 'startAtTime')
    spyOn(AbstractTone.prototype, 'stop')

    metronome = new Metronome
    new MetronomeView(metronome)
    field = $('#loop')
    lastBeat = metronome.beats.last()

    expect(field).toHaveText('Loop iteration: ---')
    metronome.start()
    expect(field).toHaveText('Loop iteration: 1')
    metronome.stop()
    expect(field).toHaveText('Loop iteration: ---')
    metronome.start()
    expect(field).toHaveText('Loop iteration: 1')
    lastBeat.onEnded()
    expect(field).toHaveText('Loop iteration: 2')
    lastBeat.onEnded()
    expect(field).toHaveText('Loop iteration: 3')
    metronome.stop()
    expect(field).toHaveText('Loop iteration: ---')

  describe "Asynchronous:", ->
    describe "Auto-logs metronome usage:", ->
      it "off", ->
        loadFixtures "metronome_logeeOff"
        spyOn(Metronome.prototype, 'startAtTime')
        spyOn(AbstractTone.prototype, 'stop')

        expectations = ->
          models = entries.models
          console.log('Off',models.map((e) -> e.get('contents')))
          expect(models.length).toBe(0)

        fetchOptions =
          success: (collection) =>
            @flag = true # should never get here
        fetch = (logEntry) ->
          entries.fetch(fetchOptions)

        metronome = new Metronome
        entries = metronome.logEntries

        runs((=>
          @flag = false
          metronome.listenTo(metronome, 'createdLogEntry', fetch)
          metronome.start()
          setTimeout((=>@flag = true), 900)), 1000)
        waitsFor((=>return @flag),"Flag to be set", 1500)
        runs(expectations)

      it "no-op", ->
        loadFixtures "metronome_logeeA"
        spyOn(Metronome.prototype, 'startAtTime')
        spyOn(AbstractTone.prototype, 'stop')

        expectations = ->
          models = entries.models
          console.log('A',models.map((e) -> e.get('contents')))
          expect(models.length).toBe(0)

        fetchOptions =
          success: (collection) =>
            @flag = true
        fetch = (logEntry) ->
          entries.fetch(fetchOptions)

        metronome = new Metronome
        entries = metronome.logEntries

        runs((=>
          @flag = false
          fetch()), 1000)
        waitsFor((=>return @flag),"Flag to be set", 1500)
        runs(expectations)

      it "started", ->
        loadFixtures "metronome_logeeB"
        spyOn(Metronome.prototype, 'startAtTime')
        spyOn(AbstractTone.prototype, 'stop')

        expectations = =>
          models = entries.models
          console.log('B',models.map((e) -> e.get('contents')))
          expect(models.length).toBe(1)
          expect(models.last().get('contents')).toBe('Started.')
          expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))

        fetchOptions =
          success: (collection) =>
            @flag = true
        fetch = (@logEntry) =>
          entries.fetch(fetchOptions)

        metronome = new Metronome
        entries = metronome.logEntries

        runs((=>
          @flag = false
          metronome.start()
          metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
        waitsFor((=>return @flag),"Flag to be set", 1500)
        runs(expectations)

      it "stopped", =>
        loadFixtures "metronome_logeeC"
        spyOn(Metronome.prototype, 'startAtTime')
        spyOn(AbstractTone.prototype, 'stop')

        expectations = =>
          models = entries.models
          console.log('C',models.map((e) -> e.get('contents')))
          expect(models.length).toBe(1)
          expect(models.last().get('contents')).toBe('Stopped.')
          expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))

        fetchOptions =
          success: (collection) =>
            @flag = true
        fetch = (@logEntry) =>
          entries.fetch(fetchOptions)

        metronome = new Metronome
        entries = metronome.logEntries

        runs((=>
          @flag = false
          metronome.stop()
          metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
        waitsFor((=>return @flag),"Flag to be set", 1500)
        runs(expectations)

      it "started then stopped", ->
        loadFixtures "metronome_logeeD"
        spyOn(Metronome.prototype, 'startAtTime')
        spyOn(AbstractTone.prototype, 'stop')

        expectations1 = =>
          models = entries.models
          console.log('D1',models.map((e) -> e.get('contents')))
          expect(models.length).toBe(1)
          expect(models.last().get('contents')).toBe('Started.')
          expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))

        expectations2 = =>
          models = entries.models
          console.log('D2',models.map((e) -> e.get('contents')))
          expect(models.length).toBe(2)
          expect(models.first().get('contents')).toBe('Started.')
          expect(models.last().get('contents')).toBe('Stopped.')
          expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))

        fetchOptions =
          success: (collection) =>
            @flag = true
        fetch = (@logEntry) =>
          entries.fetch(fetchOptions)

        metronome = new Metronome
        entries = metronome.logEntries

        runs((=>
          @flag = false
          metronome.start()
          metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
        waitsFor((=>return @flag),"Flag to be set", 1500)
        runs(expectations1)

        runs((=>
          @flag = false
          metronome.stop()
          metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
        waitsFor((=>return @flag),"Flag to be set", 1500)
        runs(expectations2)

      describe "Records settings:", ->

        it "started", ->
          loadFixtures "metronome_logeeE"
          spyOn(Metronome.prototype, 'startAtTime')
          spyOn(AbstractTone.prototype, 'stop')

          expectations = =>
            models = entries.models
            console.log('E',models.map((e) -> e.get('contents')))
            expect(models.length).toBe(1)
            expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))
            expect(models.last().get('time')).toEqual(@logEntry.get('time'))
            contentLines = models.last().get('contents').lines()
            expect(contentLines[0]).toBe('Started.')
            expect(contentLines[1]).toBe('')
            expect(contentLines[2]).toBe('Classic ticks per minute: 15')
            expect(contentLines[3]).toBe('Classic ticks per beat: 3')
            expect(contentLines[4]).toBe('')
            expect(contentLines[5]).toBe('Background tone?: true')
            expect(contentLines[6]).toBe('Background tone on all ticks?: true')
            expect(contentLines[7]).toBe('Classic tone?: true')
            expect(contentLines[8]).toBe('Mute right & left for classic?: true')
            expect(contentLines[9]).toBe('Right hand tone?: true')
            expect(contentLines[10]).toBe('Left hand tone?: true')
            expect(contentLines[11]).toBe('Right/Left in stereo?: false')
            expect(contentLines[12]).toBe('Loop?: false')
            expect(contentLines[13]).toBe('Use Entire Piece?: false')
            expect(contentLines[14]).toBe('')
            expect(contentLines[15]).toBe('Begin beat index: 2')
            expect(contentLines[16]).toBe('Begin measure index: 2')
            expect(contentLines[17]).toBe('End beat index: 3')
            expect(contentLines[18]).toBe('End measure index: 3')

          fetchOptions =
            success: (collection) =>
              @flag = true
          fetch = (@logEntry) =>
            entries.fetch(fetchOptions)

          metronome = new Metronome
          entries = metronome.logEntries

          runs((=>
            @flag = false
            metronome.start()
            metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
          waitsFor((=>return @flag),"Flag to be set", 1500)
          runs(expectations)

        it "stopped", ->
          loadFixtures "metronome_logeeF"
          spyOn(Metronome.prototype, 'startAtTime')
          spyOn(AbstractTone.prototype, 'stop')

          expectations = =>
            models = entries.models
            console.log('F',models.map((e) -> e.get('contents')))
            expect(models.length).toBe(1)
            expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))
            expect(models.last().get('time')).toEqual(@logEntry.get('time'))
            contentLines = models.last().get('contents').lines()
            expect(contentLines[0]).toBe('Stopped.')
            expect(contentLines.length).toBe(1)

          fetchOptions =
            success: (collection) =>
              @flag = true
          fetch = (@logEntry) =>
            entries.fetch(fetchOptions)

          metronome = new Metronome
          entries = metronome.logEntries

          runs((=>
            @flag = false
            metronome.stop()
            metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
          waitsFor((=>return @flag),"Flag to be set", 1500)
          runs(expectations)

        it "started then stopped", ->
          loadFixtures "metronome_logeeG"
          spyOn(Metronome.prototype, 'startAtTime')
          spyOn(AbstractTone.prototype, 'stop')

          expectations1 = =>
            models = entries.models
            console.log('G1',models.map((e) -> e.get('contents')))
            expect(models.length).toBe(1)
            expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))
            expect(models.last().get('time')).toEqual(@logEntry.get('time'))
            contentLines = models.last().get('contents').lines()
            expect(contentLines[0]).toBe('Started.')
            expect(contentLines[1]).toBe('')
            expect(contentLines[2]).toBe('Classic ticks per minute: 15')
            expect(contentLines[3]).toBe('Classic ticks per beat: 3')
            expect(contentLines[4]).toBe('')
            expect(contentLines[5]).toBe('Background tone?: true')
            expect(contentLines[6]).toBe('Background tone on all ticks?: true')
            expect(contentLines[7]).toBe('Classic tone?: true')
            expect(contentLines[8]).toBe('Mute right & left for classic?: true')
            expect(contentLines[9]).toBe('Right hand tone?: true')
            expect(contentLines[10]).toBe('Left hand tone?: true')
            expect(contentLines[11]).toBe('Right/Left in stereo?: false')
            expect(contentLines[12]).toBe('Loop?: false')
            expect(contentLines[13]).toBe('Use Entire Piece?: false')
            expect(contentLines[14]).toBe('')
            expect(contentLines[15]).toBe('Begin beat index: 2')
            expect(contentLines[16]).toBe('Begin measure index: 2')
            expect(contentLines[17]).toBe('End beat index: 3')
            expect(contentLines[18]).toBe('End measure index: 3')

          expectations2 = =>
            models = entries.models
            console.log('G2',models.map((e) -> e.get('contents')))
            expect(models.length).toBe(2)

            contentLines = models.first().get('contents').lines()
            expect(contentLines[0]).toBe('Started.')
            expect(contentLines[1]).toBe('')
            expect(contentLines[2]).toBe('Classic ticks per minute: 15')
            expect(contentLines[3]).toBe('Classic ticks per beat: 3')
            expect(contentLines[4]).toBe('')
            expect(contentLines[5]).toBe('Background tone?: true')
            expect(contentLines[6]).toBe('Background tone on all ticks?: true')
            expect(contentLines[7]).toBe('Classic tone?: true')
            expect(contentLines[8]).toBe('Mute right & left for classic?: true')
            expect(contentLines[9]).toBe('Right hand tone?: true')
            expect(contentLines[10]).toBe('Left hand tone?: true')
            expect(contentLines[11]).toBe('Right/Left in stereo?: false')
            expect(contentLines[12]).toBe('Loop?: false')
            expect(contentLines[13]).toBe('Use Entire Piece?: false')
            expect(contentLines[14]).toBe('')
            expect(contentLines[15]).toBe('Begin beat index: 2')
            expect(contentLines[16]).toBe('Begin measure index: 2')
            expect(contentLines[17]).toBe('End beat index: 3')
            expect(contentLines[18]).toBe('End measure index: 3')

            expect(models.last().get('contents')).toEqual(@logEntry.get('contents'))
            expect(models.last().get('time')).toEqual(@logEntry.get('time'))
            contentLines = models.last().get('contents').lines()
            expect(contentLines[0]).toBe('Stopped.')
            expect(contentLines.length).toBe(1)

          fetchOptions =
            success: (collection) =>
              @flag = true
          fetch = (@logEntry) =>
            entries.fetch(fetchOptions)

          metronome = new Metronome
          entries = metronome.logEntries

          runs((=>
            @flag = false
            metronome.start()
            metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
          waitsFor((=>return @flag),"Flag to be set", 1500)
          runs(expectations1)

          runs((=>
            @flag = false
            metronome.stop()
            metronome.listenTo(metronome, 'createdLogEntry', fetch)), 1000)
          waitsFor((=>return @flag),"Flag to be set", 1500)
          runs(expectations2)





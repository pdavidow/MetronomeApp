class window.Metronome extends Backbone.Model

  initialize: ->
    @data = gon.audio_data
    @metronome_setting = @data.metronome_setting
    @isLoop = @metronome_setting.is_loop
    @beats = @makeBeats()
    @ticks = (each.ticks for each in @beats).flatten()
    @isStereo = @makeIsStereo()
    @isLogUsage = @metronome_setting.is_log_usage
    @isLogSettings = @metronome_setting.is_log_settings
    @userId = @data.user_id if @data.user_id?
    @pieceId = @data.piece_id if @data.piece_id?
    @logEntries = new LogEntries(@userId, @pieceId) # if nil args, no harm

  makeBeats: ->
    beatAmount = @data.beats.length
    classForIndex = (i) -> if i is beatAmount-1 then MetronomeLastBeat else Beat
    ((new (classForIndex(i))(@, each)) for each,i in @data.beats)

  makeIsStereo: ->
    return false unless @metronome_setting.is_stereo_for_right_left
    return true if @metronome_setting.is_right_hand_tick
    return true if @metronome_setting.is_left_hand_tick
    false

  setCurrentBeatToFirst: ->
    @setCurrentBeatTo(@beats.first())

  setCurrentBeatTo: (beat) ->
    @set('currentBeat', beat)

  start: ->
    eventName = 'started'
    @startAtTime(window.context.currentTime)
    @trigger(eventName)
    @logUsage(eventName, LogEntry_Start) if @isLogUsage

  startAtTime: (@timeAtStart) ->
    @tickStartTimeOffset = 0
    @startTicks()

  startTicks: ->
    @startTick(each) for each in @ticks

  startTick: (tick) ->
    tick.startAtTime(@timeAtStart + @tickStartTimeOffset)
    @tickStartTimeOffset = @tickStartTimeOffset + tick.waitSeconds

  logUsage: (eventName, klass=LogEntry) ->
    contents = eventName.capitalize() + '.'
    logEntry = new klass(userId: @userId, pieceId: @pieceId, contents: contents, isLogSettings: @isLogSettings)
    @listenTo(logEntry, 'created', @createdLogEntry)
    logEntry.doSave()

  createdLogEntry: (logEntry) ->
    @trigger('createdLogEntry', logEntry)

  stop: ->
    @stopTicks()
    @stopped()

  stopTicks: ->
    each.stop() for each in @ticks

  stopped: ->
    eventName = 'stopped'
    @trigger(eventName)
    @logUsage(eventName) if @isLogUsage

  onEnded: ->
    if @isLoop then @loop() else @stopped()

  loop: ->
    @startAtTime(@timeAtStart + @tickStartTimeOffset)
    @trigger('looped')







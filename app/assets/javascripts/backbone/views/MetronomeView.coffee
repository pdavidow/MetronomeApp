window.MetronomeView = Backbone.View.extend

  template: JST['backbone/templates/Metronome']

  events:
    'click button#start': 'start'
    'click button#stop': 'stop'

  initialize: (@model, passedEl=null) ->
    @$el = (if passedEl? then passedEl else $('#metronome'))
    @listenTo(@model, 'started', @started)
    @listenTo(@model, 'stopped', @stopped)
    @render()

  start: ->
    @model.start()

  stop: ->
    @model.stop()

  started: ->
    $("button#start").prop('disabled', true)
    $("button#stop").prop('disabled', false)

  stopped: ->
    @setInitialState()

  setInitialState: ->
    @model.setCurrentBeatToFirst()
    @initialzeDOM()

  initialzeDOM: ->
    $("button#start").prop('disabled', not gon.is_enable_metronome_start)
    $("button#stop").prop('disabled', true)

  render: ->
    @$el.html(@template())
    @setInitialState()
    @renderSubViews()
    @

  renderSubViews: ->
    @subViews().each((e) -> e.render())

  subViews: ->
    @mySubViews = @makeMySubViews() unless @mySubViews?
    @mySubViews

  makeMySubViews: ->
    array = []
    array.add(new CurrentBeatView(@model, @$('#current_beat')))
    array.add(new LoopView(@model, @$('#loop')))
    array.add(new LogEntryView(@model, @$('#log_entry'))) if @model.isLogUsage
    array

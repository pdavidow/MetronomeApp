window.MetronomeViewerView = Backbone.View.extend

  template: JST['backbone/templates/MetronomeViewer']

  events:
    'click #toggle': 'toggle'

  initialize: (options) ->
    @isMirror = false
    @$el = $('#metronome')
    @model.on('started', @started)
    @model.on('stopped', @stopped)
    @render()

  started: ->
    $('#toggle').prop('disabled', true)

  stopped: ->
    $('#toggle').prop('disabled', false)

  toggle: ->
    @isMirror = not @isMirror
    @render()

  render: ->
    @$el.html(@template())
    new MetronomeView(@model, @$('#metronome1'))
    new MetronomeView(@model, @$('#metronome2')) if @isMirror
    @


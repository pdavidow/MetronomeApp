window.CurrentBeatView = Backbone.View.extend

  template: JST['backbone/templates/CurrentBeat']

  initialize: (@model, passedEl=null) ->
    @$el = (if passedEl? then passedEl else $('#current_beat'))
    @listenTo(@model, 'change:currentBeat', @render)

  render: ->
    @$el.html(@template(model: @model))
    @
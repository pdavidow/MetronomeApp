window.LoopView = Backbone.View.extend

  template: JST['backbone/templates/Loop']

  initialize: (@model, passedEl=null) ->
    @$el = (if passedEl? then passedEl else $('#loop'))
    @count = 0
    @listenTo(@model, 'started looped', @increment)
    @listenTo(@model, 'stopped', @reset)
    @render()

  increment: ->
    @count += 1
    @render()

  reset: ->
    @count = 0
    @render()

  render: ->
    return unless @model.isLoop
    @$el.html(@template(iteration: @count))
    @
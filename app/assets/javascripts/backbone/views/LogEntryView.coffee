window.LogEntryView = Backbone.View.extend

  template: JST['backbone/templates/LogEntry']

  initialize: (@model, passedEl=null) ->
    @$el = (if passedEl? then passedEl else $('#log_entry'))
    @entries = @model.logEntries
    @listenTo(@model, 'createdLogEntry', @nab)

  nab: (@logEntry) ->
    @render()

  render: ->
    return unless @logEntry?
    @$el.html(@template(lines: @logEntry.get('contents').lines()))
    @$el.find('p').fadeOut(4000)
    @
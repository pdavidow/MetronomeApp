class window.LogEntries extends Backbone.Collection

  constructor: (@userId, @pieceId) ->
    @models = []

  model: LogEntry

  url: ->
    "/users/#{@userId}/pieces/#{@pieceId}/log_entries"


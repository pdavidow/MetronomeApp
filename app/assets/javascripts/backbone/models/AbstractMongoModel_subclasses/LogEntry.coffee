class window.LogEntry extends window.AbstractMongoModel

  urlRoot: ->
    "/users/#{@get('userId')}/pieces/#{@get('pieceId')}/log_entries"

  doSave: ->
    @save({contents: @get('contents')}, @options())

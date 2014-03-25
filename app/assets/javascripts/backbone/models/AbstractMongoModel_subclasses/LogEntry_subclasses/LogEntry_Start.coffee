class window.LogEntry_Start extends window.LogEntry

  urlRoot: ->
    if @get('isLogSettings')
      return "/users/#{@get('userId')}/pieces/#{@get('pieceId')}/log_entries/create_settings"
    super()

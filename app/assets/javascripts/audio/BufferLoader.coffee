# From http://www.html5rocks.com/en/tutorials/webaudio/intro/js/buffer-loader.js

class window.BufferLoader

  constructor: (context, urlList, callback) ->
    @context = context
    @urlList = urlList
    @onload = callback
    @bufferList = new Array()
    @loadCount = 0

  loadBuffer: (url, index) ->
    #Load buffer asynchronously
    request = new XMLHttpRequest()
    request.open("GET", url, true)
    request.responseType = "arraybuffer"

    loader = this

    request.onload = ->
      # Asynchronously decode the audio file data in request.response
      loader.context.decodeAudioData(
        request.response,
        ((buffer) ->
          if (!buffer)
            alert('error decoding file data: ' + url)
            return
          loader.bufferList[index] = buffer
          loader.onload(loader.bufferList) if (++loader.loadCount == loader.urlList.length)),
        ((error) ->
          console.error('decodeAudioData error', error)) )

    request.onerror = ->
      alert('BufferLoader: XHR error')

    request.send()

  load: ->
    for each, i in this.urlList
      @loadBuffer(each, i)




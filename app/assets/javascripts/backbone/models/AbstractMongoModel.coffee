class window.AbstractMongoModel extends Backbone.Model

  # from http://stackoverflow.com/questions/12390553/how-to-make-backbones-and-mongodbs-ids-work-seamlessly/12391151#12391151
  # Encapsulates conversion between mongo _id and backbone id

  parse: (response) ->
    response.id = response._id.$oid
    delete(response._id)
    response

  toJSON: ->
    json = Backbone.Model.prototype.toJSON.apply(@)
    json._id = {'$oid':json.id}
    delete(json.id)
    json

  options: ->
    success: (model) ->
      model.trigger('created', model)
      className = model.constructor.name
      console.log("#{className} was successfully created.")
    error: (model, response) ->
      console.log("Error: #{response.status} #{response.statusText}")

'use strict'

# IndexModel = require '../models/index'

#module.exports = (router) ->
module.exports = (app) ->
  # model = new IndexModel()

  app.get '/', (req, res) ->
    #res.render 'index', model
    res.send 'Hello world!'

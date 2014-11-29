'use strict'

# IndexModel = require '../models/index'

#module.exports = (router) ->
module.exports = (app) ->
  # model = new IndexModel()

  app.get '/', (req, res) ->
    res.render 'index',
    	foo: 'bar'

    #req.session.foo = 'foobar'
    #console.log req.session


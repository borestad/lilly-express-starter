'use strict'

# IndexModel = require '../models/index'

#module.exports = (router) ->
module.exports = (router) ->
  # model = new IndexModel()

  router.get '/', (req, res) ->
    res.render 'index',
    	foo: 'bar'



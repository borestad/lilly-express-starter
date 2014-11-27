'use strict'

express   = require('express')
colors    = require 'colors'
pkg       = require 'package.json'
util      = require 'util'
http      = require 'http'
Benchmark = require 'benchmark'
glob      = require 'glob'

app = express()

module.exports = (callback) ->

  # Global accesspoint of the config
  app.config =
    performance:
      timing: process.hrtime()
    port: process.env.PORT or 8000
    pkg: pkg


  glob "api/controllers/*.coffee", (err, files) ->
    for file in files
      require(file)(app)

    #
    # Create and start HTTP server.
    #


    # unless module.parent

    #
    # This is only done when this module is run directly, e.g. `node .` to allow for the
    # application to be used in tests without binding to a port or file descriptor.
    #

    server = http.createServer(app)
    server.listen(app.config.port)

    server.on "listening", ->
      require('./hooks/http/start').start(app).initialize.apply @, arguments
      callback(server, app)



'use strict'

debug     = require('debug')('http')
express   = require 'express'
app       = express()
colors    = require 'colors'
pkg       = require 'package.json'
util      = require 'util'
http      = require 'http'
Benchmark = require 'benchmark'
glob      = require 'glob'

module.exports = app


# Global accesspoint of the config
app.config =
  performance:
    timing: process.hrtime()
  port: process.env.PORT or 8000
  pkg: pkg


controllers = glob.sync 'api/controllers/**/*.coffee'
for file in controllers
  require(file)(app)

#bootstrap = glob.sync 'api/bootstrap/**/*.coffee'

#console.log controllers, bootstrap

# Create and start HTTP server.
server = http.createServer(app)
server.listen(app.config.port)

server.on "listening", ->
  require('./hooks/http/start').start(app).initialize.apply @, arguments





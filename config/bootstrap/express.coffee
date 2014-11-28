'use strict'

debug             = require('debug')('http')
_                 = require 'lodash'
Benchmark         = require 'benchmark'
bodyParser        = require 'body-parser'
colors            = require 'colors'
compress          = require 'compression'
connectAssets     = require 'connect-assets'
cookieParser      = require 'cookie-parser'
csrf              = require('lusca').csrf()
errorHandler      = require 'errorhandler'
express           = require 'express'
expressValidator  = require 'express-validator'
flash             = require 'express-flash'
glob              = require 'glob'
http              = require 'http'
logger            = require 'morgan'
methodOverride    = require 'method-override'
mongoose          = require 'mongoose'
passport          = require 'passport'
path              = require 'path'
session           = require 'express-session'
util              = require 'util'


app = express()
module.exports = app


# Global accesspoint of the config
app.config =
  performance:
    timing: process.hrtime()
  port: process.env.PORT or 8000


###
	Create config object
###
for file in glob.sync 'config/*.coffee'
  app.config = _.extend app.config, require(file)

for file in glob.sync 'api/controllers/**/*.coffee'
  require(file)(app)

app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)
app.use expressValidator()
app.use methodOverride()
app.use cookieParser()


#bootstrap = glob.sync 'api/bootstrap/**/*.coffee'

#console.log controllers, bootstrap

# Create and start HTTP server.
server = http.createServer(app)
server.listen(app.config.port)

server.on "listening", ->
  require('./hooks/http/start').start(app).initialize.apply @, arguments





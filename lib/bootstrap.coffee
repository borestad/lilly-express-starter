'use strict'

debug             = require('debug')('http')
_                 = require 'lodash'
Benchmark         = require 'benchmark'
connectAssets     = require 'connect-assets'
connectMongo      = require 'connect-mongo'
errorHandler      = require 'errorhandler'
express           = require 'express'
glob              = require 'glob'
http              = require 'http'
mongoose          = require 'mongoose'
path              = require 'path'
config            = require '../config/config'
nunjucks          = require 'nunjucks'

config.set 'cwd', process.cwd()
config.set 'env', process.env.NODE_ENV or 'development'
config.set 'views:path', path.join(__dirname, '../api/views')

###
# Setup
###
app = express()
router = express.Router()

app.set 'views', config.get('views:path')
app.set 'view engine', config.get('views:engine')

###
# Global Config
###
app.config = config
# config = app.config = _.extend nconfig,
#   performance:
#     timing: process.hrtime()

###*
Connect to MongoDB.
###
mongoose.connect config.get('db:url')
mongoose.connection.on "error", ->
  console.error "MongoDB Connection Error. Please make sure that MongoDB is running."


###
# Create config object
###
for file in glob.sync 'config/*.coffee'
  app.config = _.extend app.config, require(file)


require('./middleware')(app, router)

# configure nunjucks to work with Express
env = new nunjucks.Environment(new nunjucks.FileSystemLoader(app.get 'views'))
env.express(app);

# # 500 Error Handler.
# if env is 'development'
#   app.use errorHandler()

for file in glob.sync 'api/controllers/**/*.controller.coffee'
  require(file)(router)

# Create and start HTTP server.
server = http.createServer(app)
server.listen(app.config.get('http:port'))

server.on "listening", ->
  require('config/bootstrap/hooks/http/start').start(app).initialize.apply @, arguments


module.exports = app
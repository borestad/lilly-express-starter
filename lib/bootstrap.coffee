'use strict'

debug             = require('debug')('http')
_                 = require 'lodash'
Benchmark         = require 'benchmark'
bodyParser        = require 'body-parser'
colors            = require 'colors'
compress          = require 'compression'
connectAssets     = require 'connect-assets'
connectMongo      = require 'connect-mongo'
cookieParser      = require 'cookie-parser'
errorHandler      = require 'errorhandler'
express           = require 'express'
expressValidator  = require 'express-validator'
flash             = require 'express-flash'
glob              = require 'glob'
http              = require 'http'
lusca             = require 'lusca'
methodOverride    = require 'method-override'
mongoose          = require 'mongoose'
morgan            = require 'morgan'
passport          = require 'passport'
path              = require 'path'
session           = require 'express-session'
util              = require 'util'
config            = require '../config/config'

env = process.env.NODE_ENV or 'development'

###
# Setup
###
app = express()

# ###
# # Global Config
# ###
app.config = config
# config = app.config = _.extend nconfig,
#   performance:
#     timing: process.hrtime()

#app.set('views', config.root + '/app/views');
#app.set('view engine', 'ejs');


###*
Connect to MongoDB.
###
mongoose.connect config.get('db:url')
mongoose.connection.on "error", ->
  console.error "MongoDB Connection Error. Please make sure that MongoDB is running."


csrf = lusca.csrf()
MongoStore = connectMongo(session)


###
# Create config object
###
for file in glob.sync 'config/*.coffee'
  app.config = _.extend app.config, require(file)


# Compression
app.use compress()

# Logging
app.use morgan('dev', {})

# # Public directory
app.use express.static(path.join(__dirname, '../../public'),
  maxAge: 24 * 3600 * 365.25 * 1000
)

app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)
app.use expressValidator()
app.use methodOverride()
app.use cookieParser()


app.use (req, res, next) ->
  next();

app.use session(
  resave: true
  saveUninitialized: true
  secret: 'foobar'
  store: new MongoStore(
    url: config.get('session:mongodb:url')
    auto_reconnect: true
  )
)
app.use passport.initialize()
app.use passport.session()
app.use flash()

# # 500 Error Handler.
# if env is 'development'
#   app.use errorHandler()

#bootstrap = glob.sync 'api/bootstrap/**/*.coffee'

#console.log controllers, bootstrap

for file in glob.sync 'api/controllers/**/*.coffee'
  require(file)(app)


# Create and start HTTP server.
server = http.createServer(app)
server.listen(app.config.get('http:port'))

server.on "listening", ->
  require('../config/bootstrap/hooks/http/start').start(app).initialize.apply @, arguments


module.exports = app
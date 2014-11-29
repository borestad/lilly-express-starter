debug             = require('debug')('http')
_                 = require 'lodash'
express           = require 'express'
bodyParser        = require 'body-parser'
compress          = require 'compression'
connectAssets     = require 'connect-assets'
connectMongo      = require 'connect-mongo'
cookieParser      = require 'cookie-parser'
errorHandler      = require 'errorhandler'
expressValidator  = require 'express-validator'
flash             = require 'express-flash'
http              = require 'http'
lusca             = require 'lusca'
methodOverride    = require 'method-override'
mongoose          = require 'mongoose'
morgan            = require 'morgan'
passport          = require 'passport'
path              = require 'path'
session           = require 'express-session'
config            = require '../config/config'


module.exports  = (app) ->
	# Compression
	app.use compress()

	csrf = lusca.csrf()
	MongoStore = connectMongo(session)

	# Logging
	app.use morgan('dev', {})

	# # Public directory
	app.use express.static(path.join(__dirname, '../public'),
	  maxAge: 24 * 3600 * 365.25 * 1000
	)

	app.use bodyParser.json()
	app.use bodyParser.urlencoded(extended: true)
	app.use expressValidator()
	app.use methodOverride()
	app.use cookieParser()

	app.use (req, res, next) ->
	  console.log res.config
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

	return app
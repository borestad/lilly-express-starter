nconf = require 'nconf'

nconf.overrides
	always: "be this value"

# `process.env` or `process.argv`
nconf.env().argv()

nconf.defaults

	#***************************************************************************
	# Bootstrap settings
	# (config.bootstrap)
	#***************************************************************************
	bootstrap: {}


	#***************************************************************************
	# HTTP server settings
	# (config.http)
	#***************************************************************************
	http:
		port: 8000


	#***************************************************************************
	# Log settings
	# (config.log)
	#***************************************************************************
	log:
		level: 'info'


	#***************************************************************************
	# Session settings
	# (config.session)
	#***************************************************************************
	session:
		adapter: 'mongodb'
		cookie:
			maxAge: 24 * 60 * 60 * 1000
			secret: 'S3CRET_K3Y'
		mongodb:
			url: "mongodb://localhost:27017/lilly-express-starter/sessions"


	#***************************************************************************
	# Views settings
	# (config.views)
	#***************************************************************************
	views:
		engine: 'swig'


	#***************************************************************************
	# Database settings
	# (config.db)
	#***************************************************************************
	db:
		url: "mongodb://localhost:27017/lilly-express-starter"


exports = module.exports = nconf

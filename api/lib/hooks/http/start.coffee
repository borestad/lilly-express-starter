module.exports.start = (app) ->
	colors  = require 'colors'
	config  = app.config
	pkg 	= app.config.pkg

	configure: ->

	initialize: (cb) ->

	  console.log "\n--------------------------------------------------------".grey
	  console.log "  Package        : #{pkg.name.green}"
	  console.log "  Version        : #{pkg.version}"
	  console.log "  Time           : #{new Date()}"
	  console.log "  Dependencies   : #{Object.keys(pkg.dependencies).length}"
	  console.log "  Used heap      : #{ (process.memoryUsage().heapUsed / 1024 / 1024).toFixed(2)} MB"
	  console.log "  Bootstrap time : xxx ms"
	  console.log "  PID            : #{process.pid}"
	  console.log "  Node           : #{process?.versions?.node}"
	  console.log "  Process title  : #{process?.title}"
	  console.log ""
	  console.log "  Environment    : [#{app.settings.env}]"
	  console.log "  Listening on   : #{('http://localhost:' + config.port).cyan.underline}"
	  console.log "--------------------------------------------------------".grey
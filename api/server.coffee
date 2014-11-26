"use strict"
now     = Date.now()
app     = require('express')()
colors  = require 'colors'
pkg     = require 'package.json'
util    = require 'util'

#options = require("./lib/spec")(app)
#userLib = require("./lib/user")()

port 	= process.env.PORT or 8000

console.log "\n--------------------------------------------------------".grey
console.log "  Package        : #{pkg.name.green}"
console.log "  Version        : #{pkg.version}"
console.log "  Time           : #{new Date()}"
console.log "  Dependencies   : #{Object.keys(pkg.dependencies).length}"
console.log "  Used heap      : #{ (process.memoryUsage().heapUsed / 1024 / 1024).toFixed(2)} MB"
console.log "  Bootstrap time : #{Date.now() - now} ms"
console.log "  PID            : #{process.pid}"
console.log "  Node           : #{process?.versions?.node}"
console.log "  Ruby           : #{process?.env?.RUBY_VERSION}"
console.log "  Process title  : #{process?.title}"
console.log ""
console.log "  Environment    : [#{app.settings.env}]"
console.log "  Listening on   : #{('http://localhost:' + port).cyan.underline}"

console.log "--------------------------------------------------------".grey

app.listen port, (err) ->


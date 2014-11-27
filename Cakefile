#
# UTILS
#

log = (cb) ->
  ->
    console.log "\u001b[90m'#{arguments[0].arguments[0]}' script executed \u001b[39m"
    cb()

sh = ->
  require 'shelljs'

npmExec = (cmd) ->
  "./node_modules/.bin/#{cmd}"

#
# NPM SCRIPT TASKS
#

task "npm:prepublish", log ->
  # Don't use this task within npm install
  # https://github.com/npm/npm/issues/3059

task "npm:postpublish", log ->

task "npm:preinstall", log ->
task "npm:postinstall", log ->

task "npm:preuninstall", log ->
task "npm:postuninstall", log ->

task "npm:prestart", log ->
task "npm:poststart", log ->

task "npm:pretest", log ->
task "npm:posttest", log ->

task "npm:prerestart", log ->
task "npm:postrestart", log ->

task "npm:preupdate", log ->
task "npm:postupdate", log ->

task "test", log ->
task "deploy", log ->
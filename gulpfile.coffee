gulp            = require 'gulp'
concat          = require 'gulp-concat'
filter          = require 'gulp-filter'
uglify          = require 'gulp-uglify'
mainBowerFiles 	= require 'main-bower-files'


filterByExtension = (extension) ->
  filter (file) ->
    file.path.match new RegExp("." + extension + "$")


gulp.task "default", ->
  # Reads bower.json -> 'dependencies' -> **/bower.json
  mainFiles = mainBowerFiles()

  # No main files found. Skipping....
  return unless mainFiles.length

  jsFilter = filterByExtension 'js'

  gulp.src(mainFiles)
  	.pipe jsFilter
  	.pipe concat('vendor.js')
    .pipe uglify(preserveComments: 'some', source_map: true)
  	.pipe gulp.dest('./public/vendor')
  	.pipe jsFilter.restore()
  	.pipe filterByExtension('css')
  	.pipe concat('vendor.css')
  	.pipe gulp.dest('./public/vendor')

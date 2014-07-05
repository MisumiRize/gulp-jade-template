gulp = require "gulp"
coffeelint = require "gulp-coffeelint"
coffee = require "gulp-coffee"

gulp.task "coffee", ->
  gulp.src "./src/*.coffee"
    .pipe do coffeelint
    .pipe do coffee
    .pipe gulp.dest "./"

gulp.task "default", ["coffee"]

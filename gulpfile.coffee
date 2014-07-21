gulp = require "gulp"
coffeelint = require "gulp-coffeelint"
coffee = require "gulp-coffee"
mocha = require "gulp-mocha"

gulp.task "test", ["coffee"], ->
  gulp.src "./test/*.coffee"
    .pipe do coffeelint
    .pipe mocha reporter: "spec"

gulp.task "coffee", ->
  gulp.src "./src/*.coffee"
    .pipe do coffeelint
    .pipe do coffee
    .pipe gulp.dest "./"

gulp.task "default", ["test"]

{expect} = require "chai"
jadeTemplate = require "../"
gutil = require "gulp-util"
fs = require "fs"
path = require "path"

createFile = (dataFileName, contents) ->
  base = path.join __dirname, "fixtures"
  filePath = path.join base, dataFileName

  new gutil.File
    cwd: __dirname
    base: base
    path: filePath
    contents: contents || fs.readFileSync filePath

describe "gulp-jade-template", ()->
  describe "jadeTemplate()", ()->
    it "passes file when file is null", (done)->
      stream = jadeTemplate()
      emptyFile = isNull: ()-> true
      stream.on "data", (data)->
        expect(data).to.be.equal emptyFile
        done()
      stream.write emptyFile

    it "emits error when file is stream", (done)->
      stream = jadeTemplate()
      streamFile =
        isNull: ()-> false
        isStream: ()-> true
      stream.on "error", (err)->
        expect(err.message).to.be.equal "Stream is not supported"
        done()
      stream.write streamFile

    it "compiles the jade file", (done)->
      stream = jadeTemplate filename: path.join __dirname, "fixtures", "test.jade"
      dataFile =
        isNull: ()-> false
        isStream: ()-> false
        isBuffer: ()-> true
      stream.on "data", (data)->
        done()
      stream.write dataFile

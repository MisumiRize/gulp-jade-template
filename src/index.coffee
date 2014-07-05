through = require "through2"
jade = require "jade"
gutil = require "gulp-util"
_ = require "lodash"
fs = require "fs"

PLUGIN_NAME = "gulp-jade-template"

module.exports = (options = {}) ->
  options.locals = options.locals ? {}

  transform = (file, encoding, callback) ->
    opts = _.cloneDeep options

    if file.data
      _.merge opts.locals, file.data

    file.path = gutil.replaceExtension file.path, ".html"

    if file.isStream()
      @emit "error", new gutil.PluginError PLUGIN_NAME, "Stream is not supported"
      return callback()

    if file.isBuffer()
      file.contents = new Buffer jade.compile(fs.readFileSync(opts.filename), opts)(opts.locals)

    @push file
    callback()

  through.obj transform

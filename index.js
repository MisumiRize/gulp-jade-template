(function() {
  var PLUGIN_NAME, fs, gutil, jade, through, _;

  through = require("through2");

  jade = require("jade");

  gutil = require("gulp-util");

  _ = require("lodash");

  fs = require("fs");

  PLUGIN_NAME = "gulp-jade-template";

  module.exports = function(options) {
    var transform, _ref;
    if (options == null) {
      options = {};
    }
    options.locals = (_ref = options.locals) != null ? _ref : {};
    transform = function(file, encoding, callback) {
      var opts;
      opts = _.cloneDeep(options);
      if (file.data) {
        _.merge(opts.locals, file.data);
      }
      file.path = gutil.replaceExtension(file.path, ".html");
      if (file.isStream()) {
        this.emit("error", new gutil.PluginError(PLUGIN_NAME, "Stream is not supported"));
        return callback();
      }
      if (file.isBuffer()) {
        file.contents = new Buffer(jade.compile(fs.readFileSync(opts.filename), opts)(opts.locals));
      }
      this.push(file);
      return callback();
    };
    return through.obj(transform);
  };

}).call(this);

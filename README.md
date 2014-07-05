gulp-jade-template
==================

[Gulp](https://github.com/gulpjs/gulp) plugin for template with [Jade](https://github.com/visionmedia/jade)

## Install

```
npm install gulp-jade-template
```

## Usage

This can be used with gulp-data plugin.

```
npm install gulp-data
```

Called from gulpfile.js.

```javascript
var gulp = require('gulp');
var data = require('gulp-data');
var jadeTemplate = require('gulp-jade-template');

/*
  Read data via JSON file
*/
var getJsonData = function(file, callback) {
  callback(JSON.parse(String(file.contents)));
}

gulp.task('json-test', function() {
  return gulp.src('./examples/test.json')
    .pipe(data(getJsonData))
    .pipe(jadeTemplate({ filename: './examples/template.jade' }))
    .pipe(gulp.dest('build'));
});
```

You can access assigned variables from the template file.

```
doctype html
html
  head
    title= title
  body
    h1= my.awesome.data
```

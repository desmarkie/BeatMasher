var gulp = require('gulp');
require('gulp-grunt')(gulp);
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var config = require('../config').scripts.coffee;

gulp.task('scripts', function(){
	gulp.run('grunt-percolate');
})

/*var gulp = require('gulp');
var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var config = require('../config').scripts.coffee;

gulp.task('scripts', function(){
	gulp.src(config.src)
		.pipe(sourcemaps.init())
		.pipe(coffee(config.opts).on('error', gutil.log))
		.pipe(sourcemaps.write())
		.pipe(concat(config.outputName))
		.pipe(gulp.dest(config.dest))
});*/
var gulp = require('gulp');
var gutil = require('gulp-util');
var watch = require('gulp-watch');
var config = require('../config');

gulp.task('watch', function(){
	watch(config.html.src, function(files, cb){
		gulp.start('html', cb);
	});
	watch(config.scripts.coffee.src, function(files, cb){
		gulp.start('scripts', cb);
	});
	watch(config.images.src, function(files, cb){
		gulp.start('images', cb);
	});
});
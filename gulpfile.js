var gulp = require('gulp');
var gutil = require('gulp-util');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var coffee = require('gulp-coffee');
var cache = require('gulp-cached');
var remember = require('gulp-remember');
var plumber = require('gulp-plumber');

task = {
	"source": ["index.coffee", "lib/**/*.coffee"]
}

gulp.task('coffee', function() {
	return gulp.src(task.source, {base: "."})
		.pipe(plumber())
		.pipe(cache("coffee"))
		.pipe(coffee({bare: true}).on('error', gutil.log)).on('data', gutil.log)
		.pipe(remember("coffee"))
		.pipe(gulp.dest("."));
});


/* Watcher */
gulp.task('watch', function () {
	gulp.watch(task.source, ['coffee']);
});

gulp.task("default", ["coffee", "watch"]);

/*
File: gulpfile.js
Description: Script for tasks
License: MIT
-----------------------------------------------------------
Author: William Canin
-----------------------------------------------------------
*/

'use strict';

/* LOAD PLUGINS
______________________________________________________________________________________ */

    var gulp = require( 'gulp' ),
        jshint = require('gulp-jshint'),
        uglify = require('gulp-uglify'),
        rename = require('gulp-rename'),
        imagemin = require('gulp-imagemin'),
        cp = require('child_process'),
        taskListing = require('gulp-task-listing');

/* VARIABLES FILES AND DIRECTORYS
______________________________________________________________________________________ */

    // var path = require('./sources/json/paths.json');
    var configs = require('./lib/json/gulp.json');


/* COMPRESS JAVASCRIPTS
______________________________________________________________________________________ */

    gulp.task('javascripts', function() {
      gulp.src(configs.sources.js.files)
        .pipe(jshint())
        .pipe(rename({ suffix: '.min' }))
        .pipe(uglify())
        .pipe(gulp.dest(configs.assets.javascripts.dir+'/'))
    });

/* IMAGE MINIFY
______________________________________________________________________________________ */

    gulp.task('imagemin', function () {
        gulp.src(configs.assets.images.files)
            .pipe(imagemin())
            .pipe(gulp.dest(configs.assets.images.dir+'/'))
    });

/* JEKYLL BUILD
______________________________________________________________________________________ */

    gulp.task('jekyll-build', function (done) {
        return cp.spawn('bundle', ['exec','jekyll','build'], {stdio: 'inherit'})
            .on('close', done);
    });

/* JEKYLL SERVE [DEPRECATED]
______________________________________________________________________________________ */
// Note: The Jekyll watch function is being disabled. The watch will be monitored by the Gulp task

    gulp.task('jekyll-serve', function (done) {
        return cp.spawn('bundle', ['exec','jekyll','serve', '--no-watch'/*,'--incremental'*/], {stdio: 'inherit'})
            .on('close', done);
    });


/* REBUILD WHEN IS CHANGED FILES
______________________________________________________________________________________ */

    gulp.task('watch-files', function () {
        gulp.watch(configs.watch, ['javascripts','jekyll-build']);
    });

/* TASKS DEFAULTS
______________________________________________________________________________________ */

    gulp.task('default', taskListing.withFilters(/:/));
    gulp.task('build', ['javascripts','imagemin','jekyll-build']);
    gulp.task('serve', ['javascripts','watch-files']);

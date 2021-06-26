/*
File: gulpfile.babel.js
Description: Script for tasks in Gulp (using ES6)
License: MIT
-----------------------------------------------------------
Author: William Canin
-----------------------------------------------------------
*/

/* Note: Due to a bug, the use of ES6 and Babel must be version 3.9.0 of Gulp.*/

/* LOAD PLUGINS
______________________________________________________________________________________ */

    const gulp = require('gulp');
    const jshint = require('gulp-jshint');
    const uglify = require( 'gulp-uglify');
    const rename = require('gulp-rename');
    const babel = require('gulp-babel');
    const imagemin = require ('gulp-imagemin');
    const cp  = require('child_process');
    const bsCreate = require('browser-sync');
    const taskListing = require('gulp-task-listing');
    // import configs for gulp
    const configs = require('./lib/json/gulp.json');

/* VARIABLES FILES AND DIRECTORYS
______________________________________________________________________________________ */

    // Const browser sync create
    const browserSync = bsCreate();

/* COMPRESS JAVASCRIPTS
______________________________________________________________________________________ */

    gulp.task('javascripts', () => {
      return gulp.src(configs.sources.js.files)
        .pipe(jshint())
        .pipe(rename({ suffix: '.min' }))
        .pipe(babel({
          presets: ['@babel/env']
        }))
        .pipe(uglify())
        .pipe(gulp.dest(configs.assets.javascripts.dir+'/'))
    });

/* IMAGE MINIFY
______________________________________________________________________________________ */

    gulp.task('imagemin', () => {
      return gulp.src(configs.assets.images.files)
        .pipe(imagemin({ optimizationLevel: 5 }))
        .pipe(gulp.dest(configs.assets.images.dir+'/'))
    });

/* JEKYLL BUILD/PRODUCTION AND REBUILD
______________________________________________________________________________________ */
    let build_options = {stdio: 'inherit'};
    const env = Object.create(process.env);
    env.JEKYLL_ENV = 'production';
    build_options.env = env;

    gulp.task('jekyll-production', (done) => {
      return cp.spawn('bundle', ['exec','jekyll','build'], build_options)
        .on('close', done);
    });

    gulp.task('jekyll-build', (done) => {
      return cp.spawn('bundle', ['exec','jekyll','build'], {stdio: 'inherit'})
        .on('close', done);
    });

    gulp.task('jekyll-rebuild', ['jekyll-build'], () => {
      return browserSync.reload();
    });


/* JEKYLL SERVE [DEPRECATED]
______________________________________________________________________________________ */
// Note: The Jekyll watch function is being disabled. The watch will be monitored by the Gulp task

    // gulp.task('jekyll-serve', (done) => {
    //   return cp.spawn('bundle', ['exec','jekyll','serve', '--no-watch'/*,'--incremental'*/], {stdio: 'inherit'})
    //    .on('close', done);
    // });

/* CHANGE URL FOR PRODUCTION AND BUILD
______________________________________________________________________________________ */

    gulp.task('url-serve', (done) => {
      return cp.spawn('ruby', ['lib/rb/runtime/url_server.rb'], {stdio: 'inherit'})
        .on('close', done);
    });

    gulp.task('url-build', (done) => {
      return cp.spawn('ruby', ['lib/rb/runtime/url_build.rb'], {stdio: 'inherit'})
        .on('close', done);
    });

/* START SERVER
______________________________________________________________________________________ */

    gulp.task('browser-sync', ['jekyll-build'], () => {
      return  browserSync.init({
      // reloadDelay: 2000,
        port: configs.browserSync.port,
        server: {
          baseDir: configs.browserSync.baseDir
        }
      });
    });

/* REBUILD WHEN IS CHANGED FILES
______________________________________________________________________________________ */

    gulp.task('watch-files', () =>{
      return  gulp.watch(configs.watch, ['javascripts','jekyll-rebuild']);
    });


/* TASKS DEFAULTS
______________________________________________________________________________________ */

    gulp.task('default', taskListing.withFilters(/:/));
    gulp.task('build', ['url-build','javascripts','imagemin','jekyll-production']);
    gulp.task('serve', ['url-serve','javascripts','browser-sync', 'watch-files']);

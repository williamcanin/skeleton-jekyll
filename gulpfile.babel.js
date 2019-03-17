"use strict";

import postcss from 'gulp-postcss';
import autoprefixer from 'autoprefixer';
import cssnano from 'cssnano';
import sass from 'gulp-sass';
import { src, dest, series, parallel, watch } from 'gulp';
import rename from 'gulp-rename';
import uglify from 'gulp-uglify';
import {spawn} from 'child_process';
import plumber from 'gulp-plumber';
import eslint from 'gulp-eslint';
import del from 'del';
import imagemin from 'gulp-imagemin';
import browserSync from 'browser-sync';


// Configuration and variables global.
// import fs from 'fs';
// let configs = JSON.parse(fs.readFileSync('./lib/json/gulp.json'));
let bsCreate = browserSync.create();
let configs = {
  gulpfile: 'gulpfile.babel.js',
  watch: [
    // Folder _pages/**/*.md is in trouble
    '_config.yml',
    '_layouts/**/*.html',
    '_includes/**/*.html',
    '_data/**/*.yml',
    '_blog/**/*.html',
    '_sass/**/*.scss',
    'src/js/**/*.js'
  ],
  server: {
    dir: './_site/',
    port: '3010'
  },
  src:{
    js:{
      files: './src/js/**/*.js'
    },
    scss:{
      default: './scss/style.scss',
      files: './scss/**/*.scss'
    }
  },
  assets:{
    js:{
      files: './assets/js/*',
      dir: './assets/js/'
    },
    css:{
      dir: './assets/css/'
    },
    images:{
      dir: './assets/images/',
      files: './assets/images/**/*'
    }
  }
};

// Cleans
function clean() {
  return del([configs.assets.js.files]);
}

// SASS / CSS 
// // If you do not use the jekyll _sass folder, uncomment this option.
// function style() {
//   return src(configs.src.scss.default)
//     .pipe(plumber())
//     .pipe(sass({ outputStyle: "expanded" }))
//     .pipe(dest(configs.assets.css.dir))
//     .pipe(rename({ suffix: ".min" }))
//     .pipe(postcss([autoprefixer(), cssnano()]))
//     .pipe(dest(configs.assets.css.dir))
//     .pipe(bsCreate.stream());
// }

// BrowserSync
function server(done) {
  bsCreate.init({
    server: {
      baseDir: configs.server.dir
    },
    port: configs.server.port
  });
  done();
}

// // BrowserSync Reload
function server_reload(done) {
  bsCreate.reload();
  done();
}

// Optimize Images
function images() {
  return src(configs.assets.images.files)
    .pipe(
      imagemin([
        imagemin.gifsicle({ interlaced: true }),
        imagemin.jpegtran({ progressive: true }),
        imagemin.optipng({ optimizationLevel: 5 }),
        imagemin.svgo({
          plugins: [
            {
              removeViewBox: false,
              collapseGroups: true
            }
          ]
        })
      ])
    )
    .pipe(dest(configs.assets.images.dir));
}

// Jekyll build
function jekyll_build() {
  return spawn('bundle', ['exec','jekyll','build'], {stdio: 'inherit'});
}

// Watch files
function watchfiles() {
  // // If you do not use the jekyll _sass folder, uncomment this option.
  // gulp.watch(configs.src.scss.files, style);
  watch(configs.watch, series(jekyll_build, server_reload));
}

// Lint scripts
function jslint() {
  return src([configs.src.js.files, configs.gulpfile])
    .pipe(plumber())
    .pipe(eslint())
    .pipe(eslint.format())
    .pipe(eslint.failAfterError());
}

// Scripts
function scripts() {
  return (
    src(configs.src.js.files)
    .pipe(plumber())
    .pipe(rename({ suffix: '.min' }))
    .pipe(uglify())
    .pipe(dest(configs.assets.js.dir))
  );
}

// Define complex tasks
let js = series(jslint, scripts);
let build = series(clean, parallel(style, images, js, jekyll_build));
let dev = parallel(jekyll_build, server, watchfiles);
// let dev = parallel(jekyll_build, server, server_reload, watchfiles);

// export tasks
exports.clean = clean;
exports.style = style;
exports.js = js;
exports.images = images;
exports.build = build;
exports.dev = dev;

'use strict';
var gulp        = require('gulp'),
    cache       = require('gulp-cache'),
    browserSync = require('browser-sync').create(),
    reload      = browserSync.reload,
    sass        = require('gulp-sass'),
    pug         = require('gulp-pug'),
    concat      = require('gulp-concat'),
    coffee      = require('gulp-coffee'),
    uglify      = require('gulp-uglify'),
    es          = require('event-stream'),
    plumber     = require('gulp-plumber'),
    imagemin    = require('gulp-imagemin'),
    prefix      = require('gulp-autoprefixer'),
    gutil       = require('gulp-util'),
    sourcemaps  = require('gulp-sourcemaps'),
    entorno  = gutil.env.env === 'prod';

gulp.task('clear', function (done) {
  cache.clearAll(done);
});

gulp.task('javascript', ['clear'], function() {
  es.merge(
    gulp.src('source/coffee/*.coffee')
        .pipe(plumber())
        .pipe(coffee({bare: true})),
    gulp.src('source/coffee/*.js'))
        .pipe( entorno ? uglify({compress:{drop_console: true}}) : gutil.noop())
        .pipe(concat('app.js'))
        .pipe( gulp.dest('dist/js/'))
        .pipe(browserSync.reload({stream: true}));
});

gulp.task('coffee', ['clear'], function(){
  gulp.src('source/coffee/*.coffee')
      .pipe(plumber())
      .pipe(coffee({bare: true}))
      .pipe( entorno ? uglify({compress:{drop_console: true}}) : gutil.noop())
      .pipe(gulp.dest('./dist/js/'))
      .pipe(browserSync.reload({stream: true}));
});

gulp.task('sass', ['clear'], function () {
  gulp.src('./source/sass/*.scss')
      .pipe(plumber())
      //.pipe(sourcemaps.init())
      .pipe(sass())
      .pipe( entorno ? sass({outputStyle:'compressed'}) : gutil.noop())
      .pipe(prefix({browsers: ['last 2 versions', 'ie 8', 'ie 9', '> 1%', 'Firefox >= 20', 'Opera 12.1','iOS 7'], cascade: false}))
      .pipe(sourcemaps.write('.'))
      .pipe(gulp.dest('./dist/css'))
      .pipe(browserSync.reload({stream: true}));
});

gulp.task('templates', ['clear'], function() {
  gulp.src('./source/jade/*.pug')
      .pipe(pug({
        pretty: true
      }))
      .pipe(gulp.dest('./dist'))
      .pipe(browserSync.reload({stream: true}));
});

gulp.task('images', function() {
  gulp.src('./vendor/images/**/*.{png,jpg,jpeg,gif,svg}')
      .pipe(imagemin({
        optimizationLevel: 3,
        progessive: true,
        interlaced: true
      }))
      .pipe(gulp.dest('./dist/images'))
});
gulp.task('fonts', function() {
  gulp.src(['source/vendor/fonts/**/*.{eot,svg,ttf,woff,woff2}'])
      .pipe(gulp.dest('dist/fonts/'));
});
gulp.task('plugins', function() {
    return gulp.src( 'vendor/js/*.js' )
        .pipe( concat('vendor_all.js') )
        .pipe(uglify())
        .pipe( gulp.dest('dist/js/vendor'))
        .pipe(browserSync.reload({stream: true}));
});

// Static server
gulp.task('serve', ['templates', 'sass', 'javascript'],function() {
  browserSync.init({
    open: false,
    server: './dist',
    port: 3030
  });
  gulp.watch('./source/sass/*.scss', ['sass']);
  gulp.watch('./source/coffee/*.coffee',  ['js']);
  gulp.watch('./source/coffee/*.js',  ['js']);
  gulp.watch('./source/jade/**/*.pug',  ['templates']);
  gulp.watch('dist/*.html').on('change', reload);
});

gulp.task('vendor', ['images','fonts', 'plugins']);
gulp.task('default', ['serve','vendor']);

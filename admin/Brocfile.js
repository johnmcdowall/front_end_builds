/* global require, module */
var fs   = require('fs');
var path = require('path');
var path_join = function(){
  // fix path with windows back slash with path_join
  return path.join.apply(this, arguments).replace(/\\/g, '/');
};

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp({
  fingerprint: {
    prepend: '/front_end_builds/'
  },
  emberCliFontAwesome: { includeFontAwesomeAssets: false }
});

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.
app.import("bower_components/bootstrap/dist/css/bootstrap.css");
app.import("bower_components/bootstrap/dist/js/bootstrap.js");

// Font Awesome
var fonts = [
  "fontawesome-webfont.eot",
  "fontawesome-webfont.svg",
  "fontawesome-webfont.ttf",
  "fontawesome-webfont.woff",
  "fontawesome-webfont.woff2",
  "FontAwesome.otf"
];
var fontDestDir = (app.env === 'production') ? '/assets' : '/front_end_builds/assets/';
fonts.forEach(function(font) {
  app.import('bower_components/font-awesome/fonts/' + font, { destDir: fontDestDir });
});

if (app.env === 'production') {
  app.import('vendor/production-pretender/shim.js', {
    type: 'vendor',
    exports: { 'pretender': ['default'] }
  });
}

module.exports = app.toTree();

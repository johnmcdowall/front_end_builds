/* jshint node: true */
function usingProxy() {
  return !!process.argv.filter(function (arg) {
    return arg.indexOf('--proxy') === 0;
  }).length;
}

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'admin',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    usePodsByDefault: true,
    podModulePrefix: 'admin/pods',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  ENV['usePretender'] = (environment !== 'production' && !usingProxy());

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.baseURL = 'BASEURL';
  }

  return ENV;
};

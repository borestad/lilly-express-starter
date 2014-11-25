var path = require('path'),
    rootPath = path.normalize(__dirname + '/..'),
    env = process.env.NODE_ENV || 'development';

var config = {
  development: {
    root: rootPath,
    app: {
      name: 'lilly-express-starter'
    },
    port: 3000,
    db: 'mongodb://localhost/lilly-express-starter-development'
    
  },

  test: {
    root: rootPath,
    app: {
      name: 'lilly-express-starter'
    },
    port: 3000,
    db: 'mongodb://localhost/lilly-express-starter-test'
    
  },

  production: {
    root: rootPath,
    app: {
      name: 'lilly-express-starter'
    },
    port: 3000,
    db: 'mongodb://localhost/lilly-express-starter-production'
    
  }
};

module.exports = config[env];

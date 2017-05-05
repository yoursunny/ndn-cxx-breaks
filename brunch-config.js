// See http://brunch.io for documentation.
exports.files = {
  javascripts: {
    joinTo: {
      'vendor.js': /^(?!app)/,
      'app.js': /^app/
    }
  }
};

exports.plugins = {
  babel: {presets: ['latest', 'react']}
};

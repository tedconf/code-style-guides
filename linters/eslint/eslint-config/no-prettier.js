var error = 'error';
var warn = 'warn';

module.exports = {
  extends: ['eslint-config-airbnb'].map(require.resolve),

  plugins: ['react-hooks', 'eslint-comments'],

  rules: {
    'react-hooks/rules-of-hooks': error,
    'react-hooks/exhaustive-deps': warn,
    'eslint-comments/disable-enable-pair': error,
    'eslint-comments/no-aggregating-enable': error,
    'eslint-comments/no-duplicate-disable': error,
    'eslint-comments/no-unlimited-disable': error,
    'eslint-comments/no-unused-disable': warn,
    'eslint-comments/no-unused-enable': warn,
  },
};

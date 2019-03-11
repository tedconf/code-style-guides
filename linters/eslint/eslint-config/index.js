module.exports = {
  extends: [
    'eslint-config-airbnb',
    'eslint-config-prettier',
    'eslint-config-prettier/babel',
    'eslint-config-prettier/react',
  ].map(require.resolve),
  rules: {},
};

module.exports = {
  extends: [
    'eslint-config-airbnb',
    'eslint-config-prettier',
    'eslint-config-prettier/babel',
    'eslint-config-prettier/react',
  ].map(require.resolve),

  plugins: [
    'react-hooks',
  ],

  rules: {
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'warn',
  },
};

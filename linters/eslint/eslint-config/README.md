# TED Conferences shared extensible eslint config

## Installation

Because of how eslint does config and plugin resolution this is a two step process for now. (For more details read: https://github.com/eslint/eslint/issues/3458)

```shell
# For yarn
yarn add --dev @tedconf/eslint-config
# For npm
npm install -D @tedconf/eslint-config
```

Then you need to install the peer dependencies

```shell
# If you have npm > 5
npx install-peerdeps --dev @tedconf/eslint-config
# If you are somehow stuck on an older version of npm (reconsider your lifechoices then)
npm info "@tedconf/eslint-config" peerDependencies
```

## Usage

Read up on how to use [sharable configs](http://eslint.org/docs/developer-guide/shareable-configs) at the ESLint website. Essentially, add the following to the project's `.eslintrc` file:

```json
{
  "extends": "@tedconf"
}
```

## Philosophy

We want to minimize the bikeshedding and discussion of rules. Our rule set is based of of [airbnb-eslint-config](https://www.npmjs.com/package/eslint-config-airbnb), which is widely used in the community. The basic change to that rule set is to apply eslint-config-prettier afterwards and to let [prettier](https://prettier.io/) handle the formatting.

#!/bin/bash

# We need a local version of fbjs so we're not including other files by
# reference and confusing our build system. :(
npm install fbjs@0.8.16

# Store copies of the three fbjs libraries we need in the `fbjs` directory.
# We've already modified files like `factory.js` in this way:
#
# BEFORE:
# var emptyFunction = require('fbjs/emptyFunction');
#
# AFTER:
# var emptyFunction = require('./fbjs/emptyFunction.js');
rm -rf fbjs
mkdir fbjs
cp node_modules/fbjs/lib/emptyFunction.js fbjs
cp node_modules/fbjs/lib/invariant.js fbjs
cp node_modules/fbjs/lib/warning.js fbjs

# There's one require in warning.js that we'd like to point to our new
# directory. Use sed to modify this in-place.
sed -i '' "s/require('.\/emptyFunction')/require('.\/emptyFunction.js')/" ./fbjs/warning.js

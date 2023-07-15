#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

# The CLI will take care of setting up the ENV variables
cd "$(dirname "$0")/cli" || exit 1
npm install
npm run start

#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

# Print the current directory
echo "Current directory: $(pwd)"

# List the contents of the current directory
echo "Directory contents:"
ls -la

# The CLI will take care of setting up the ENV variables
cd "$(dirname "$0)"/cli || cd cli || exit 1
npm install
npm run start


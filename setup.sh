#!/usr/bin/env bash

# The CLI will take care of setting up the ENV variables
cd /app/cli || exit 1

# Build the Next.js app
npm run build

# Start the production server
npm run start




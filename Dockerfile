# Use a base image with the necessary dependencies
FROM node:14

# Set the environment variable for memory limit
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json files to the container
COPY next/package*.json /app/

# Install dependencies with caching layer
RUN npm ci

# Copy the setup.sh script to the container
COPY setup.sh /app/setup.sh

# Copy the next directory to the container
COPY next /app/next
COPY next /app/cli

# Copy the platform directory to the container
COPY platform /app/platform

# Copy the db directory to the container
COPY db /app/db

# Copy the docs directory to the container
COPY docs /app/docs

# Make the setup.sh script executable
RUN chmod +x /app/setup.sh

# Run the setup.sh script with the --docker-compose argument
CMD ["/bin/bash", "/app/setup.sh", "--docker-compose", "--timeout", "500"]

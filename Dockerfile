# Use a base image with Node.js pre-installed
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the setup.sh script to the container
COPY setup.sh /app/setup.sh

# Make the setup.sh script executable
RUN chmod +x /app/setup.sh

# Set the setup.sh script as the entrypoint
ENTRYPOINT ["/app/setup.sh"]




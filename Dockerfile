# Use a base image with Node.js pre-installed
FROM node:14

# Set the working directory in the container
WORKDIR /

# Copy the setup.sh script to the container
COPY setup.sh /setup.sh

# Make the setup.sh script executable
RUN chmod +x /setup.sh

# Set the setup.sh script as the entrypoint
ENTRYPOINT ["/setup.sh"]



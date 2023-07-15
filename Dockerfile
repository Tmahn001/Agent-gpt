# Use a base image with Node.js pre-installed
FROM node:14

# Set the working directory in the container
WORKDIR /

# Copy the setup.sh script to the container
COPY setup.sh /setup.sh

# Make the setup.sh script executable
RUN chmod +x /setup.sh

# Run the setup.sh script
CMD ["/bin/bash", "/setup.sh"]


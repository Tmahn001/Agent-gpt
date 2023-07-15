# Use a base image with Node.js pre-installed
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the setup.sh script to the container
COPY setup.sh /app/setup.sh

# Run the setup.sh script
RUN chmod +x /app/setup.sh
CMD ["/bin/bash", "/app/setup.sh"]


# Use a base image with the necessary dependencies
FROM node:14

# Copy the setup.sh script to the container
COPY setup.sh /app/setup.sh

# Make the setup.sh script executable
RUN chmod +x /app/setup.sh

# Run the setup.sh script
CMD ["/bin/bash", "/app/setup.sh"]





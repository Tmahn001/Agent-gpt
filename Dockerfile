
# Use a base image with the necessary dependencies
FROM node:14



# Copy the setup.sh script to the container
COPY setup.sh /app/setup.sh

# Copy the next directory to the container
COPY next /app/next

# Copy the platform directory to the container
COPY platform /app/platform

# Copy the db directory to the container
COPY db /app/db

# Copy the docs directory to the container
COPY docs /app/docs

# Make the setup.sh script executable
RUN chmod +x /app/setup.sh

# Set the working directory
WORKDIR /app

# Run the setup.sh script
CMD ["/bin/bash", "/app/setup.sh"]





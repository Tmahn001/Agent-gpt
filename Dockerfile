# Use an appropriate base image
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the setup.sh script to the working directory
COPY setup.sh .

# Make the setup.sh script executable
RUN chmod +x setup.sh
RUN apk add --no-cache bash

# Run the setup.sh script when the container starts
CMD ["./setup.sh"]

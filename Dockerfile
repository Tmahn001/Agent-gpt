# Use the appropriate base image for your backend (Python, for example)
FROM python:3.11-slim-buster as prod

# Set the working directory for the backend
WORKDIR /app

# Install backend dependencies
COPY platform/requirements.txt .
RUN pip install -r requirements.txt

# Copy the backend source code
COPY platform/ .

# Run the backend application
CMD ["python", "app.py"]

# Use the official Node.js image as the base image for the frontend
FROM node:19-alpine

# Set the working directory for the frontend
WORKDIR /next

# Copy package.json and package-lock.json to the working directory
COPY next/package*.json ./

# Install frontend dependencies
RUN npm ci

# Copy the wait-for-db.sh script to the appropriate location
COPY next/wait-for-db.sh /usr/local/bin/wait-for-db.sh
RUN chmod +x /usr/local/bin/wait-for-db.sh

# Copy the rest of the frontend application code
COPY next/ .

# Ensure correct line endings after these files are edited by Windows
RUN apk add --no-cache dos2unix netcat-openbsd \
    && dos2unix /usr/local/bin/wait-for-db.sh

# Generate Prisma client
RUN npx prisma generate

# Build the frontend application
RUN npm run build

# Expose the port the frontend app will run on
EXPOSE 3000

# Set the entrypoint and start the application
ENTRYPOINT ["sh", "/usr/local/bin/wait-for-db.sh", "npm", "start"]

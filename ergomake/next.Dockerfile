# Use the appropriate base image for your backend (Python, for example)
FROM python:3.11-slim-buster as prod

# Set the working directory
WORKDIR /app

# Install dependencies
COPY platform/requirements.txt .
RUN pip install -r requirements.txt

# Copy the backend source code
COPY platform/ .

# Run the backend application
CMD ["python", "app.py"]

# Use the official Node.js image as the base image
FROM node:19-alpine

ARG NODE_ENV

ENV NODE_ENV=$NODE_ENV

ARG NEXT_PUBLIC_BACKEND_URL
ENV NEXT_PUBLIC_BACKEND_URL=$NEXT_PUBLIC_BACKEND_URL

ARG NEXTAUTH_URL
ENV NEXTAUTH_URL=$NEXTAUTH_URL

ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL

ARG NEXTAUTH_SECRET
ENV NEXTAUTH_SECRET=$NEXTAUTH_SECRET

# Set the working directory for the frontend
WORKDIR /next

# Copy package.json and package-lock.json to the working directory
COPY next/package*.json ./

# Install dependencies
RUN npm ci

# Copy the wait-for-db.sh script from the next folder
COPY wait-for-db.sh next/usr/local/bin/wait-for-db.sh
RUN chmod +x /usr/local/bin/wait-for-db.sh

# Copy the rest of the frontend application code
COPY next/ .

# Expose the port the app will run on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]


ENTRYPOINT ["sh", "/entrypoint.sh"]

# Start the application
CMD ["npm", "start"]

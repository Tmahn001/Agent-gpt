# Use the official Node.js image as the base image for the frontend
FROM node:19-alpine as frontend

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

# Needed for the wait-for-db script
RUN apk add --no-cache netcat-openbsd

# Set the working directory
WORKDIR /next

# Copy package.json and package-lock.json to the working directory
COPY next/package*.json ./

# Install dependencies
RUN npm ci

# Copy the wait-for-db.sh script
COPY wait-for-db.sh /usr/local/bin/wait-for-db.sh
RUN chmod +x /usr/local/bin/wait-for-db.sh

# Copy the rest of the application code
COPY next/ .

# Build the frontend application
RUN npm run build

# Expose the port the app will run on
EXPOSE 3000

# Entry point and start the application
ENTRYPOINT ["npm", "start"]

# Use the Python image as the base image for the backend
FROM python:3.11-slim-buster as backend

ARG REWORKD_PLATFORM_FRONTEND_URL
ENV REWORKD_PLATFORM_FRONTEND_URL=$REWORKD_PLATFORM_FRONTEND_URL

RUN apt-get update && apt-get install -y \
  default-libmysqlclient-dev \
  pkg-config \
  gcc \
  && rm -rf /var/lib/apt/lists/*

RUN pip install poetry==1.4.2

# Configuring poetry
RUN poetry config virtualenvs.create false

# Copying requirements of a project
COPY platform/pyproject.toml /app/src/
WORKDIR /app/src

# Installing requirements
RUN poetry install --only main

# Copying actual application
COPY platform/ /app/src/

# Expose the port the app will run on
EXPOSE 8000

# Run the backend application
CMD ["/usr/local/bin/python", "-m", "reworkd_platform"]


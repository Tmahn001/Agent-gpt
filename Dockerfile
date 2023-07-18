# Use the official Node.js image as the base image
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
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the wait-for-db.sh script
COPY wait-for-db.sh /usr/local/bin/wait-for-db.sh
RUN chmod +x /usr/local/bin/wait-for-db.sh

# Copy the rest of the application code
COPY . .
COPY entrypoint.sh /

# Ensure correct line endings after these files are edited by Windows
RUN apk add --no-cache dos2unix netcat-openbsd \
    && dos2unix /entrypoint.sh

RUN npx prisma generate
RUN npm run build

# Expose the port the app will run on
EXPOSE 3000

ENTRYPOINT ["sh", "/entrypoint.sh"]

# Start the application
CMD ["npm", "start"]

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
COPY pyproject.toml /app/src/
WORKDIR /app/src

# Installing requirements
RUN poetry install --only main
# Removing gcc
RUN apt-get purge -y \
  gcc \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

# Copying actual application
COPY . /app/src/
RUN poetry install --only main

CMD ["/usr/local/bin/python", "-m", "reworkd_platform"]

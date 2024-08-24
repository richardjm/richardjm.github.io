# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG NODE_VERSION=19.5.0

FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
ENV NODE_ENV production

WORKDIR /usr/src/app

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.npm to speed up subsequent builds.
# Leverage a bind mounts to package.json and package-lock.json to avoid having to copy them into
# into this layer.
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm 

# Copy the rest of the source files into the image.
COPY . .

# Create the folders for the volumes before chown
RUN mkdir -p /usr/src/app/.docusaurus
RUN mkdir -p /usr/src/app/node_modules

# Chown folder to allow write access in build
RUN chown -R node /usr/src/app

# Run the application as a non-root user (after the chown)
USER node

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD npm start

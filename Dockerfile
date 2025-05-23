# Stage 1: Build Angular App
FROM node:18.12-alpine AS build
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps
RUN npm install -g @angular/cli@16

# Copy the rest of the app and build it
COPY . .
RUN ng build

# Stage 2: Serve with Nginx
FROM nginx:latest
RUN apt-get update && apt-get install -y iputils-ping

# Copy built Angular files to Nginx web root


COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /usr/src/app/dist/the-bridge /usr/share/nginx/html


# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port
EXPOSE 80

# Use custom entrypoint to dynamically configure Nginx
ENTRYPOINT ["/entrypoint.sh"]

FROM node:18.17.1-bullseye AS build

ARG NPM_LOG_LEVEL=--quiet
ARG NPM_FORCE_INSTALL=--force
ARG NODE_OPTIONS=--openssl-legacy-provider
ENV NODE_OPTIONS=${NODE_OPTIONS}

WORKDIR /app

# Copie les fichiers nécessaires pour installer les dépendances
COPY package*.json ./

# Installation avec cache Docker
RUN npm ci ${NPM_LOG_LEVEL} || npm install ${NPM_FORCE_INSTALL} ${NPM_LOG_LEVEL}

# Ensuite on copie le reste du projet
COPY . .

# Build
RUN npm run build-prod ${NPM_LOG_LEVEL}

FROM nginx:latest

# Copier uniquement le build final
COPY --from=build /app/dist/*/ /usr/share/nginx/html
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/kantra-formation.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Étape 1 : Build avec Node.js
FROM node:18.17.1-bullseye AS build

ARG NPM_LOG_LEVEL=--quiet
ARG NPM_FORCE_INSTALL=--force
ARG NODE_OPTIONS=--openssl-legacy-provider
ENV NODE_OPTIONS=${NODE_OPTIONS}

WORKDIR /code/9antraFormationFront/
COPY . .

# Installation des dépendances + build de l'application
RUN npm ci ${NPM_LOG_LEVEL} || npm install ${NPM_FORCE_INSTALL} ${NPM_LOG_LEVEL} \
  && npm run build-prod ${NPM_LOG_LEVEL}

# Étape 2 : Image légère avec Nginx
FROM nginx:alpine

# Copier le build dans le dossier Nginx
COPY --from=build /code/9antraFormationFront/dist/*/ /usr/share/nginx/html

# Ajouter la config personnalisée Nginx
COPY --from=build /code/9antraFormationFront/nginx.conf /etc/nginx/conf.d/kantra-formation.conf

EXPOSE 80

# Lancement de Nginx
CMD ["nginx", "-g", "daemon off;"]

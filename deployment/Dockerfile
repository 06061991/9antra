FROM node:18.17.1-bullseye as build


ARG NPM_LOG_LEVEL=--quiet
ARG NPM_FORCE_INSTALL=--force
ARG NODE_OPTIONS=--openssl-legacy-provider
ENV NODE_OPTIONS=${NODE_OPTIONS}

WORKDIR /code/9antraFormationFront/
COPY . /code/9antraFormationFront
# bch ytbadl hdha khtr fl local docker ykhdm shih ama fl github actions bch yamli  dossier automatiquement edhka alh nkhlha./code/
RUN ls /code/9antraFormationFront
RUN cd /code/9antraFormationFront/ && rm -rf node_modules && npm i ${NPM_FORCE_INSTALL} ${NPM_LOG_LEVEL} && npm run build-prod ${NPM_LOG_LEVEL}
RUN ls /code/9antraFormationFront
RUN ls /code/
FROM nginx:latest
COPY --from=build /code/9antraFormationFront/dist/*/ /usr/share/nginx/html
COPY --from=build /code/9antraFormationFront/deployment/nginx.conf /etc/nginx/conf.d/kantra-formation.conf
CMD nginx -g 'daemon off;'
EXPOSE 80

FROM node:7.8.0
WORKDIR /opt
ADD . /opt
ARG APP_PORT
ENV PORT=$APP_PORT
RUN npm install
ENTRYPOINT npm run start
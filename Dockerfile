FROM node:10-alpine

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

ENV NODE_ENV production

RUN apk update \
  && apk add git

COPY package.json package-lock.json ./
RUN apk add --no-cache --virtual .gyp python make g++ \
    && npm ci \
    && apk del .gyp

COPY index.js ./

CMD npm run start

FROM node:10.17.0-alpine

RUN apk add --no-cache bash

RUN mkdir -p /usr/src/app

WORKDIR /usr/src

ENV PATH /app/node_modules/.bin:$PATH

RUN npm i docsify-cli -g

EXPOSE 3000

CMD [ "docsify", "serve" ]

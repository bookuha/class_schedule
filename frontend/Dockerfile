FROM node:18-alpine

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/ && cp -a /tmp/package.json /opt/app/

WORKDIR /opt/app
COPY ./public/ ./public
COPY ./src/ ./src

EXPOSE 3000

CMD ["npm", "start"]
FROM node:24-alpine AS base

WORKDIR /usr/bot
COPY . .

RUN npm install --frozen-lockfile --ignore-scripts

CMD npm start

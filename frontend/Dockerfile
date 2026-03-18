FROM node:24-alpine AS build

WORKDIR /app

COPY package*.json /app
RUN npm install

COPY . .

FROM gcr.io/distroless/nodejs24 AS deploy

WORKDIR /app

COPY --from=build /app /app

USER nonroot

CMD ["server.js"]
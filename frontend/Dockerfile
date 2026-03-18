# -------- Build Stage --------
FROM node:24-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# If needed (uncomment if applicable)
# RUN npm run build

# -------- Deploy Stage --------
FROM gcr.io/distroless/nodejs24

WORKDIR /app

COPY --from=build /app /app

USER nonroot

EXPOSE 80

CMD ["server.js"]
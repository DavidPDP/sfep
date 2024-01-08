FROM node:20 AS build-stage
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:20 AS production-deps-stage
WORKDIR /app

COPY --from=build-stage /app/package*.json ./
COPY --from=build-stage /app/dist ./
RUN npm ci --only=production

FROM gcr.io/distroless/nodejs:20-debian12
WORKDIR /app

COPY --from=production-deps-stage --chown=nonroot:nonroot /app/node_modules ./node_modules
COPY --from=production-deps-stage --chown=nonroot:nonroot /app ./

CMD ["videobuff.min.js"]

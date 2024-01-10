FROM node:20.10.0-bullseye-slim AS build-stage
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN chmod 755 node_modules/.bin/webpack && npm run build

FROM node:20.10.0-bullseye-slim AS production-deps-stage
WORKDIR /app

COPY --from=build-stage /app/package*.json ./
COPY --from=build-stage /app/dist ./
RUN npm ci --omit=dev

FROM node:20.10.0-bullseye-slim
WORKDIR /app

COPY --from=safefleet.net/ffmpeg:6.1.1 /usr/local/bin/ffmpeg /usr/local/bin/ffprobe /usr/local/bin/
COPY --from=safefleet.net/ffmpeg:6.1.1 /usr/lib/x86_64-linux-gnu/libx264.so.160 /usr/lib/x86_64-linux-gnu/
COPY --from=production-deps-stage /app/node_modules ./node_modules
COPY --from=production-deps-stage /app ./

CMD ["videobuff.min.js", "startApp"]

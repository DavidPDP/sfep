FROM debian:bullseye-slim AS build

RUN apt-get update && apt-get install -y \
  build-essential \
  yasm \
  libx264-dev \
  pkgconf \
  wget

WORKDIR /ffmpeg

RUN wget https://ffmpeg.org/releases/ffmpeg-6.1.1.tar.bz2 && \
  tar xjvf ffmpeg-6.1.1.tar.bz2 && \
  cd ffmpeg-6.1.1 && \
  ./configure \
    --disable-everything \
    --disable-network \
    --disable-autodetect \
    --enable-gpl \
    --enable-ffprobe \
    --enable-libx264 \
    --enable-bsf=h264_mp4toannexb \
    --enable-muxer=mp4 \
    --enable-demuxer=concat \
    --enable-demuxer=mov \
    --enable-protocol=file \
    --enable-protocol=pipe && \
  make -j$(nproc) && \
  make install

FROM debian:bullseye-slim

COPY --from=build /usr/local/bin/ffmpeg /usr/local/bin/ffprobe /usr/local/bin/
COPY --from=build /usr/lib/x86_64-linux-gnu/libx264.so.160 /usr/lib/x86_64-linux-gnu/

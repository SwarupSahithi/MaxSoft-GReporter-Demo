FROM maven:3.8.8-eclipse-temurin-11

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl unzip wget gnupg software-properties-common \
 && wget -q https://github.com/getgauge/gauge/releases/download/v1.5.1/gauge-linux.x86_64 \
 && chmod +x gauge-linux.x86_64 \
 && mv gauge-linux.x86_64 /usr/local/bin/gauge \
 && gauge install java \
 && gauge install html-report \
 && gauge install screenshot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

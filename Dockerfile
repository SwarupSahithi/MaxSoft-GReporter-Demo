FROM maven:3.8.8-eclipse-temurin-11

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl unzip wget gnupg software-properties-common libgconf-2-4 \
 && wget -q https://github.com/getgauge/gauge/releases/download/v1.5.1/gauge-linux.x86_64 \
 && chmod +x gauge-linux.x86_64 \
 && mv gauge-linux.x86_64 /usr/local/bin/gauge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* gauge-linux.x86_64

# Optional: copy your source code and run Maven build
# COPY . .
# RUN mvn clean compile

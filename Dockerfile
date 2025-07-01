FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    maven \
    curl \
    wget \
    gnupg \
    unzip \
    libgconf-2-4 \
    libgtk2.0-0 \
    libnotify4 \
    libnss3 \
    libxss1 \
    libxtst6 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango1.0-0 \
    libxshmfence1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Gauge binary (no zip!)
RUN wget -q https://github.com/getgauge/gauge/releases/download/v1.5.1/gauge-linux.x86_64 -O /usr/local/bin/gauge && \
    chmod +x /usr/local/bin/gauge && \
    gauge install java && \
    gauge install html-report && \
    gauge install screenshot

# Set working directory
WORKDIR /app

# Copy your Maven project
COPY . .

# Build the project
RUN mvn clean compile

# Default command (change if needed)
CMD ["gauge", "run", "specs"]

FROM ubuntu:22.04

# Set working directory
WORKDIR /app

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl wget unzip gnupg libgconf-2-4 libgtk2.0-0 libnotify4 libnss3 libxss1 libxtst6 \
    libasound2 libatk1.0-0 libatk-bridge2.0-0 libcups2 libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libpango1.0-0 libxshmfence1 \
 && wget -q https://github.com/getgauge/gauge/releases/download/v1.5.1/gauge-linux.x86_64.zip \
 && unzip gauge-linux.x86_64.zip -d gauge \
 && mv gauge/gauge /usr/local/bin/gauge \
 && chmod +x /usr/local/bin/gauge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* gauge gauge-linux.x86_64.zip
CMD ["gauge", "-v"]

# Use base image with Java and Maven
FROM maven:3.8.8-eclipse-temurin-11

# Set working directory
WORKDIR /app

# Install required tools and Gauge manually
RUN apt-get update && apt-get install -y \
    curl unzip wget gnupg software-properties-common \
 && wget -q https://github.com/getgauge/gauge/releases/download/v1.5.1/gauge-linux.x86_64.zip \
 && unzip gauge-linux.x86_64.zip -d gauge \
 && mv gauge/* /usr/local/bin/ \
 && chmod +x /usr/local/bin/gauge \
 && gauge install java \
 && gauge install html-report \
 && gauge install screenshot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* gauge gauge-linux.x86_64.zip

# Copy your project files into container
COPY . .

# Build the project (optional)
RUN mvn clean compile

# Default command (can be overridden in docker run)
CMD ["mvn", "test"]

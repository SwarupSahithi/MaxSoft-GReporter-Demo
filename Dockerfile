FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget curl unzip gnupg apt-transport-https lsb-release software-properties-common

# Add Gauge official APT repo
RUN curl -Ss https://dl.gauge.org/gauge-key.asc | gpg --dearmor -o /usr/share/keyrings/gauge-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/gauge-archive-keyring.gpg] https://dl.gauge.org/deb stable main" | tee /etc/apt/sources.list.d/gauge.list && \
    apt-get update && \
    apt-get install -y gauge openjdk-11-jdk maven

# Install Gauge plugins
RUN gauge install java && \
    gauge install html-report && \
    gauge install screenshot

# Set working directory
WORKDIR /app

# Copy your project
COPY . .

# Build project (optional)
RUN mvn clean compile

CMD ["gauge", "run", "specs"]

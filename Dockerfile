# Base image
FROM ubuntu:22.04

# Set DNS resolver to avoid name resolution issues
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Install dependencies
RUN apt-get update && apt-get install -y wget gnupg2 software-properties-common curl

# Add Gauge repo
RUN wget -qO - https://dl.gauge.org/gauge-key.asc | gpg --dearmor -o /usr/share/keyrings/gauge-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/gauge-archive-keyring.gpg] https://dl.gauge.org/deb stable main" \
    | tee /etc/apt/sources.list.d/gauge.list && \
    apt-get update && \
    apt-get install -y gauge openjdk-11-jdk maven

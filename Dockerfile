FROM getgauge/gauge:latest

# Install Java and Maven
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    maven \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build your project
RUN mvn clean compile

# Default command
CMD ["gauge", "--version"]

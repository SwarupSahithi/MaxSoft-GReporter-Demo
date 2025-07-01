# Use Maven with Java 8 base image
FROM maven:3.8.8-eclipse-temurin-8
# Set the working directory
WORKDIR /app
# Copy project files
COPY . .
# Install dependencies required by Gauge
RUN apt-get update && apt-get install -y \
    curl unzip wget gnupg software-properties-common \
 && curl -sS https://dl.gauge.org/stable -o install-gauge.sh \
 && chmod +x install-gauge.sh && ./install-gauge.sh \
 && gauge install java \
 && gauge install html-report \
 && gauge install screenshot \
 && apt-get clean



# Build the Maven project (skip tests if needed)
RUN mvn clean install -DskipTests

# Default command (change this based on usage: e.g., send email or run tests)
CMD ["mvn", "exec:java", "-Dexec.mainClass=com.maxsoft.greporter.email.EmailSender"]

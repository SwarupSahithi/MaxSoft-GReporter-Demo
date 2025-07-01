FROM getgauge/gauge-java:latest

WORKDIR /app

# Copy your Maven project files
COPY . .

# Install Maven
RUN apt-get update && apt-get install -y maven

# Optional: Run build to check
RUN mvn clean compile

CMD [ "gauge", "--version" ]

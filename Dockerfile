# ── Stage 1: Builder ───────────────────────────────────────────
FROM maven:3.8.5-openjdk-17-slim AS builder
WORKDIR /workspace

RUN apt-get update \
 && apt-get install -y curl unzip gnupg2 ca-certificates \
 && curl -SsL https://downloads.gauge.org/stable | sh \
 && gauge install java html-report

# Copy project files including specs
COPY pom.xml .
COPY src ./src
COPY specs ./specs

RUN ls -la specs && mvn clean package -DskipTests

# ── Stage 2: Runtime ───────────────────────────────────────────
FROM eclipse-temurin:17-jre-jammy AS runtime
WORKDIR /workspace

COPY --from=builder /workspace/target/*.jar app.jar
COPY --from=builder /workspace/specs ./specs
COPY --from=builder /root/.gauge /root/.gauge
ENV PATH=/root/.gauge:$PATH

RUN apt-get update \
 && apt-get install -y nodejs npm \
 && npm install -g appium

EXPOSE 4723 8080

ENTRYPOINT ["bash", "-lc", "\
  appium & sleep 5 && \
  gauge run specs && \
  java -jar app.jar"]

# ==============================================================================
# STAGE 1: Build Phase
# ==============================================================================
FROM maven:3.9.6-eclipse-temurin-25-alpine AS builder

WORKDIR /app

# Copy dependency definition to leverage Docker build cache
COPY pom.xml .

# Download dependencies offline (cache layer)
RUN mvn dependency:go-offline -B

# Copy source code and assets
COPY src ./src

# Compile SCSS files and package the application
# We activate the 'css' Maven profile to ensure stylesheet assets are compiled
RUN mvn package -P css -DskipTests

# ==============================================================================
# STAGE 2: Runtime Phase
# ==============================================================================
FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

# Create a secure, non-privileged system user to run the application
RUN addgroup -S vetsync && adduser -S vetsync -G vetsync

# Copy the packaged executable JAR from the builder stage
COPY --from=builder /app/target/spring-petclinic-*.jar ./vetsync.jar

# Set correct ownership for secure execution
RUN chown -R vetsync:vetsync /app

# Switch to the non-privileged user
USER vetsync

# Expose standard production port
EXPOSE 8080

# Production-optimized JVM runtime environment settings
ENV JAVA_OPTS="-XX:+UseG1GC \
               -XX:+UseContainerSupport \
               -XX:MaxRAMPercentage=75.0 \
               -Djava.security.egd=file:/dev/./urandom \
               -Dserver.port=8080"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar vetsync.jar"]

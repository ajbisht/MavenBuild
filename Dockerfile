# Use maven as base image to make use of maven and openjdk pre-installed
FROM maven:3.8.5-openjdk-17-slim

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml ./
COPY src ./src

# Run the maven package command to build the project
RUN mvn clean package

# Use an openjdk image to run the application after the build
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built jar from the maven image
COPY --from=0 /app/target/your-artifact-name.jar .

# Command to run the application
CMD ["java", "-jar", "your-artifact-name.jar"]

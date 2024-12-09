# Utilitza una imatge base amb suport per a Java 21
FROM eclipse-temurin:21-jdk AS build

# Configura el directori de treball
WORKDIR /app

# Copia el teu projecte
COPY . .

# Compila el projecte amb Maven
RUN ./mvnw clean package -DskipTests

# Imatge final
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia l'arxiu JAR de la compilació
COPY --from=build /app/target/*.jar app.jar

# Executa l'aplicació
ENTRYPOINT ["java", "-jar", "app.jar"]

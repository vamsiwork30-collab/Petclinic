FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY target/petclinic.war petclinic.war

EXPOSE 8082

ENTRYPOINT ["java","-jar","petclinic.war"]

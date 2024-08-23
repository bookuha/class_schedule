FROM gradle:7-jdk11 AS build
WORKDIR /usr/app/
COPY build.gradle settings.gradle system.properties pre-commit.gradle liquibase.gradle gradlew ./
COPY config ./config
COPY src ./src
RUN gradle war --stacktrace

FROM tomcat:9.0.93-jdk11 as tomcat

RUN apt-get update && apt-get install -y postgresql-client

COPY /scripts/restore_backup.sh /usr/local/bin/restore_backup.sh
RUN chmod +x /usr/local/bin/restore_backup.sh

WORKDIR /usr/local/tomcat/webapps/
COPY --from=build /usr/app/build/libs/class_schedule.war ./ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
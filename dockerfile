ARG IMAGE_NAME="openjdk"
ARG IMAGE_TAG="21-slim-bullseye"

FROM $IMAGE_NAME:$IMAGE_TAG as build

WORKDIR /BuildTools
RUN apt-get update && apt-get upgrade -y && apt-get install curl git -y
COPY ./build.sh ./build.sh
RUN chmod +x ./build.sh
RUN curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar --rev latest
RUN cp spigot-*.jar spigot-server.jar

FROM $IMAGE_NAME:$IMAGE_TAG as base
ENV EULA=false
ENV MEMORY=1024

WORKDIR /server
COPY --from=build /BuildTools/spigot-server.jar .
WORKDIR /start
COPY --from=build /BuildTools/spigot-server.jar .
COPY ./start.sh .
RUN chmod +x ./start.sh
VOLUME /server
CMD /start/start.sh


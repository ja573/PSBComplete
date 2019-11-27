FROM gradle:latest AS build
MAINTAINER Paul Fremantle (paul@fremantle.org)

WORKDIR /purchase
ADD ./ ./
RUN gradle build -x test

FROM openjdk:8-jre-alpine

WORKDIR /home/root/purchase

COPY --from=build /purchase/build/libs/purchase-0.0.2.jar ./

EXPOSE 8080
ENTRYPOINT java -jar purchase-0.0.2.jar

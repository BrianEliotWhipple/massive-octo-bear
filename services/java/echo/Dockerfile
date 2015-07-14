FROM java:8

ADD /build/libs/echo-0.1-all.jar /data/echo-0.1-all.jar
ADD echo-service.yml /data/echo-service.yml
# Will want to add keystore for HTTPS?

CMD java -jar /data/echo-0.1-all.jar server /data/echo-service.yml

EXPOSE 8080

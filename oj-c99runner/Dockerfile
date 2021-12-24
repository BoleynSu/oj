FROM docker.io/library/openjdk:11-jre@sha256:ea312fb9e9f4c041a2f076326845308a42f1f2b5fcd91dc035845f623d05a086
RUN apt update && apt install -y gcc && apt clean
RUN ln -s /usr/local/openjdk-11/bin/java /usr/bin/java

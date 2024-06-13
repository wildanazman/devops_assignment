FROM jenkins/jenkins:jdk17


USER root
WORKDIR /usr/local/
COPY ./devops_class /usr/local/devops_class
EXPOSE 8080
RUN apt-get update && apt-get install -y ca-certificates curl

RUN install -m 0755 -d /etc/apt/keyrings

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

RUN chmod a+r /etc/apt/keyrings/docker.asc

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  jammy stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update

RUN apt-get update && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


USER jenkins
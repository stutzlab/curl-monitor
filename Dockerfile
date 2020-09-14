# FROM alpine:3.12.0
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl

ENV CURL1_CMD ''
ENV CURL1_NAME ''

EXPOSE 8880

RUN curl -LJ -o /bin/promgrep https://github.com/stutzlab/promgrep/releases/download/v1.1.1/promgrep-linux-amd64 && chmod +x /bin/promgrep

ADD /startup.sh /
ADD /launch.sh /
ADD /launch-all.sh /

CMD [ "/startup.sh" ]

FROM arm32v6/alpine

LABEL image="docker-pijdownloader" \
	maintainer="bronogard" \
	url="https://github.com/bronogard/docker-pijdownloader"

WORKDIR /opt/jdownloader

ARG USER=jdownloader
ARG GROUP=jdownloader

ENV UID=666 \
	GID=666

RUN export USER=${USER} && export GROUP=${GROUP} && addgroup -g ${GID} ${GROUP} && adduser -D -u ${UID} -G ${GROUP} ${USER} \
	&& echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
        bash \
        openjdk8-jre \
        shadow \
        && rm -rf /var/cache/apk/archives /var/lib/apk/lists \
	&& wget http://installer.jdownloader.org/JDownloader.jar


COPY jdownloader.sh /usr/local/bin

VOLUME ["/opt/jdownloader/cfg", "/media"]

ENTRYPOINT ["jdownloader.sh"]

FROM ubuntu

ENV XXNET_VERSION 3.11.9

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
  && apt-get update -y

ADD https://codeload.github.com/XX-net/XX-Net/zip/"$XXNET_VERSION" ./
RUN apt-get install zip -y \
  && unzip "$XXNET_VERSION" \
  && mv XX-Net-"$XXNET_VERSION" XX-Net \
  && rm "$XXNET_VERSION"
COPY ./XX-Net/data /XX-Net/data

RUN apt-get install python2.7 python-openssl libffi-dev python-gtk2 python-appindicator libnss3-tools -y

RUN apt-get install miredo -y

RUN apt-get install supervisor -y
COPY ./etc/supervisord.conf /etc/supervisord.conf

EXPOSE 8085 8087

CMD /usr/bin/supervisord -c /etc/supervisord.conf
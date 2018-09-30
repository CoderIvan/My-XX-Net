FROM ubuntu

LABEL Author="Ivan"

ENV XXNET_VERSION 3.12.11

ADD https://github.com/XX-net/XX-Net/archive/"$XXNET_VERSION".tar.gz ./

RUN tar -zxvf "$XXNET_VERSION".tar.gz
RUN mv XX-Net-"$XXNET_VERSION" XX-Net
RUN rm "$XXNET_VERSION".tar.gz

RUN apt-get update -y
RUN apt-get install python-openssl libffi-dev python-gtk2 python-appindicator libnss3-tools -y

RUN apt-get install miredo -y
RUN service miredo start

COPY ./XX-Net/data /XX-Net/data

CMD ["XX-Net/start"]

EXPOSE 8085 8087
FROM debian:buster

RUN mkdir foldermirror
COPY ./foldermirror /foldermirror
COPY folder-mirror.xml /foldermirror
COPY broot /usr/bin


WORKDIR /foldermirror
RUN ./foldermirror import folder-mirror.xml 2> /tmp/foldermirror.log
CMD /bin/bash


FROM debian:jessie
MAINTAINER alimguzhin@di.uniroma1.it

COPY *.sh /build/

RUN /build/build.sh

RUN useradd -ms /bin/bash openmodelica

USER openmodelica
ENV USER openmodelica

CMD ["OMShell-terminal"]

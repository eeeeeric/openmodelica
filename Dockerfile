FROM debian:jessie

COPY *.sh /build/

RUN /build/build.sh

RUN useradd -ms /bin/bash openmodelica

USER openmodelica
ENV USER openmodelica

CMD ["OMShell-terminal"]

FROM debian:buster

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/eeeeeric/openmodelica.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

RUN apt-get update
RUN apt-get install -y wget gnupg
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt buster stable"; done | tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - 

RUN apt-get update
RUN apt-get install -y openmodelica

# TODO: Running as non-root segfaults...

CMD ["OMShell-terminal"]

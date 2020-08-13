FROM debian:buster

RUN apt-get update
RUN apt-get install -y wget gnupg
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt buster stable"; done | tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - 

RUN apt-get update
RUN apt-get install -y openmodelica

# TODO: Running as non-root segfaults...

CMD ["OMShell-terminal"]

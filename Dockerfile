# Vreau sa simulez un sistem gol pe care rulez prima data install_system.sh
FROM ubuntu

LABEL maintainer="cristian.lupascu@jlg.ro"
LABEL name="Utility_tests"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV HOME_FOLDER /home/cristi

ARG USER=cristi
ARG PW=docker

# Instalez sudo pentru ca by default docker nu vine cu el preinstalat
RUN apt-get update && \
      apt-get -y install sudo && \
      apt-get -y install curl

# Creez un user cu un nume oarecare. Pot testa aici diversi user name
# seteaza parola cu valoarea default definita mai sus sau cu valoarea --build-arg PW=[password in container], din comanda build
# creeaza folderul /home/[user name]
# adauga user la grupul sudo sa pot rula sudo ./install_system.sh
RUN useradd -m ${USER} && echo "${USER}:${PW}" | chpasswd | adduser ${USER} sudo


USER ${USER}
WORKDIR /home/${USER}

# Copies tot folderul proiectului aici ca si cum l-as lua de pe Github
COPY . /home/${USER}/utilities

# Pornesc un terminal pentru a tine containerul pornit
CMD /bin/bash

# FOLOSIRE:
# Pentru a face build: 
# docker build  --build-arg PW=[password in container] -t utilities:test_install .
# Daca vreau cu parola default, docker:
# docker build -t utilities:test_install .

# Pentru a rula interactiv:
# docker run -it utilities:test_install


# LINKURI FOLOSITOARE
# https://faun.pub/set-current-host-user-for-docker-container-4e521cef9ffc

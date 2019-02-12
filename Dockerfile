FROM ubuntu

LABEL maintainer="cristian.lupascu@jlg.ro"
LABEL name="Utility_tests"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV HOME_FOLDER /home/cristi

RUN apt -y update && \
	apt install -y python3.6 && \
	apt install -y python3-pip && \
	apt install -y python3-venv && \
	apt install -y neovim && \
	apt install -y vifm && \
	mkdir /home/cristi/ && \
	mkdir /home/cristi/Documents/ && \
	mkdir /home/cristi/Documents/utility_scripts/

COPY ./all_setup_skykit.sh /home/cristi/Documents/utility_scripts/all_setup_skykit.sh
COPY ./*.mongoexport /home/cristi/Documents/utility_scripts/
COPY ./functii_notes.sh /home/cristi/Documents/utility_scripts/functii_notes.sh
COPY ./functii_* /home/cristi/Documents/utility_scripts/
COPY ./mongo_notes/*.py /home/cristi/Documents/utility_scripts/mongo_notes/

CMD sh /home/cristi/Documents/utility_scripts/all_setup_skykit.sh

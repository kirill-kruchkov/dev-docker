FROM ubuntu:latest



# UPKEEPING

RUN apt-get update \
	&& apt-get --yes upgrade \
	&& echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install -y locales

RUN locale-gen en_US.UTF-8


# Install PACKAGES

RUN apt-get install --yes --quiet --no-install-recommends ca-certificates \
	sudo man less \
	build-essential cmake libssl-dev \
    apt-transport-https \
	curl wget

# Setup USER

RUN useradd --create-home --groups 'sudo' --shell '/bin/zsh' void \
	&& echo 'void ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER void
ENV USER=void \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US:en' \
	LC_ALL='en_US.UTF-8' \
	TERM=xterm-256color
WORKDIR /home/void


# Setup TinTin
RUN mkdir tintin \
  && cd tintin \
  && sudo apt-get --yes --quiet --no-install-recommends build-dep tintin++ \
  && wget http://downloads.sourceforge.net/tintin/tintin-2.01.1.tar.gz \
  && tar -zxvf tintin-2.01.1.tar.gz \
  && cd ./tt/src \
  && ./configure \
  && make \
  && sudo make install


# GO!

ENTRYPOINT ["/bin/sh"]

FROM ubuntu:latest



# UPKEEPING

RUN echo "deb-src http://gb.archive.ubuntu.com/ubuntu/ xenial main restricted" >> /etc/apt/sources.list \
  && echo "deb-src http://archive.ubuntu.com/ubuntu/ xenial main restricted" >> /etc/apt/sources.list \
  && echo "deb-src http://security.ubuntu.com/ubuntu/ xenial-security main restricted" >> /etc/apt/sources.list \
  && echo "deb-src http://security.ubuntu.com/ubuntu/ xenial-security multiverse" >> /etc/apt/sources.list

RUN apt-get update \
	&& apt-get --yes upgrade \
	&& echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get install -y locales

RUN locale-gen en_US.UTF-8


# Install APT-FAST

RUN apt-get install --yes --quiet --no-install-recommends git aria2 ca-certificates \
	&& git clone https://github.com/ilikenwf/apt-fast /tmp/apt-fast \
	&& cp /tmp/apt-fast/apt-fast /usr/bin \
	&& chmod +x /usr/bin/apt-fast \
	&& cp /tmp/apt-fast/apt-fast.conf /etc



# Install PACKAGES

RUN apt-fast install --yes --quiet --no-install-recommends --fix-missing \
	sudo man less \
	build-essential cmake libssl-dev \
  apt-transport-https \
	curl wget

# Setup USER

RUN useradd --create-home --groups 'sudo' --shell '/bin/sh' void \
	&& echo 'void ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER void
ENV USER=void \
	LANG='en_US.UTF-8' \
	LANGUAGE='en_US:en' \
	LC_ALL='en_US.UTF-8' \
	TERM=xterm-256color
WORKDIR /home/void

# Copy Discworld config

COPY ./dockerfiles/tintin-light/dw.tin ./dw.tin


# Setup TinTin
RUN mkdir tintin \
  && cd tintin \
  && sudo apt-fast --yes --quiet --no-install-recommends --fix-missing \
    build-dep tintin++ \
  && wget http://downloads.sourceforge.net/tintin/tintin-2.01.1.tar.gz \
  && tar -zxvf tintin-2.01.1.tar.gz \
  && cd ./tt/src \
  && ./configure \
  && make \
  && sudo make install


# GO!

EXPOSE 4242

ENTRYPOINT /usr/local/bin/tt++ dw.tin && /bin/sh

FROM ubuntu:latest

# UPKEEPING

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

RUN apt-fast install --yes --quiet --no-install-recommends \
	sudo man less zsh ca-certificates xclip \
	build-essential cmake libssl-dev \
	curl wget \
	git tig silversearcher-ag \
	python python-pip \
	taskwarrior apt-transport-https \
    weechat \
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



# Setup ZSH
RUN git clone https://github.com/tarjoilija/zgen.git .zgen
COPY dotfiles/zsh/.zshrc .zshrc
RUN sudo chown $USER .zshrc \
	&& touch .zsh_custom \
	&& /bin/zsh -c 'source .zshrc'



COPY dotfiles/sources.list /etc/apt/sources.list.d
RUN sudo apt-get update \
	&& sudo apt-get --yes upgrade \
    && gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
    && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add - \
    && sudo apt-fast install --yes --quiet --allow-unauthenticated --no-install-recommends tor deb.torproject.org-keyring


# GO!

ENTRYPOINT ["/bin/zsh"]

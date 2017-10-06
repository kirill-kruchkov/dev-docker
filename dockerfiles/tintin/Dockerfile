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
	sudo man less zsh ca-certificates \
	build-essential cmake libssl-dev \
	curl wget elinks lynx \
	apt-transport-https \
    tzdata build-essential

# Set TimeZone
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-fast install --yes --quiet --no-install-recommends \
	libncurses5-dev libcairo2-dev \
	liblua5.1-dev luajit libluajit-5.1 \
	python-dev ruby-dev libperl-dev \
	&& mkdir /usr/include/lua5.1/include \
    && cp /usr/include/lua5.1/*.h /usr/include/lua5.1/include/


# Install TMUX 2.3+

RUN apt-fast install --yes --quiet --no-install-recommends \
	automake libevent-dev libncurses-dev \
	&& git clone https://github.com/tmux/tmux.git /tmp/tmux \
	&& cd /tmp/tmux && ./autogen.sh && ./configure && make && make install



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
COPY ./dotfiles/zsh/.zshrc .zshrc
RUN sudo chown $USER .zshrc \
	&& touch .zsh_custom \
	&& /bin/zsh -c 'source .zshrc'



# Setup TMUX

RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
COPY ./dotfiles/tmux/.tmux.conf .tmux.conf
RUN sudo chown $USER .tmux.conf &&.tmux/plugins/tpm/bin/install_plugins


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

EXPOSE 4242

ENTRYPOINT ["/bin/zsh"]

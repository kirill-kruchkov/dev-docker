FROM ubuntu:latest

# UPKEEPING

RUN apt-get update \
	&& apt-get --yes upgrade \
	&& echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && apt-get install -y locales locales-all

RUN locale-gen en_US.UTF-8 \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && update-locale LANG=en_US.UTF-8


# Install APT-FAST

RUN apt-get install --yes --quiet --no-install-recommends git aria2 ca-certificates \
	&& git clone https://github.com/ilikenwf/apt-fast /tmp/apt-fast \
	&& cp /tmp/apt-fast/apt-fast /usr/bin \
	&& chmod +x /usr/bin/apt-fast \
	&& cp /tmp/apt-fast/apt-fast.conf /etc


# Install basic PACKAGES

RUN apt-fast install --yes --quiet --no-install-recommends \
	sudo man less zsh ca-certificates \
  software-properties-common \
	build-essential cmake \
  autogen automake libssl-dev libevent-dev libncurses5-dev pkg-config libtool \
	curl wget \
	git tig silversearcher-ag \
	python python-pip python3 python-dev python3-dev \
	taskwarrior apt-transport-https


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


# Git Config

COPY dotfiles/git/.gitconfig /home/void
COPY dotfiles/git/.gitignore_global /home/void


# Install global apps

## ZSH

RUN git clone https://github.com/tarjoilija/zgen.git .zgen
COPY dotfiles/zsh/.zshrc .zshrc
RUN sudo chown $USER .zshrc \
  && touch .zsh_custom \
  && /bin/zsh -c 'source .zshrc'


## NVM

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh


## Yarn

RUN apt-fast install gnupg --yes --quiet --no-install-recommends \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
  && apt-fast update && apt-fast install yarn --yes --quiet --no-install-recommends


## TMUX

RUN cd /home/void \
  && git clone https://github.com/tmux/tmux.git \
  && cd tmux \
	&& sh autogen.sh \
	&& ./configure && make \
  && sudo make install
COPY dotfiles/tmux/.tmux.conf /home/void


## Vim

ENV TERM=xterm-256color
COPY dotfiles/vim/.vimrc /home/void
# RUN apt-get install -y libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev
RUN git clone https://github.com/vim/vim.git
WORKDIR /home/void/vim
RUN git checkout 68f1b1b37fa7aba985d9f8727fd9f0f3eb0c19a9
RUN ./configure --with-features=huge \
            --enable-multibyte \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-python3interp \
            --with-python3-config-dir=/usr/lib/python3.4/config-3.4m-x86_64-linux-gnu \
            --enable-cscope --prefix=/usr \
            --enable-fontset \
            --enable-largefile \
            --disable-netbeans \
            --with-compiledby="Kirill K." \
            --enable-fail-if-missing
RUN sudo make VIMRUNTIMEDIR=/usr/share/vim/vim81
RUN sudo make install
WORKDIR /home/void
RUN sudo rm -rf vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY dotfiles/tern/.tern-config /home/void


# Initialisation

COPY init.sh /home/void/.init.sh

RUN /bin/zsh -c "source ~/.zshrc && . ~/.init.sh"

# GO!

EXPOSE 8000
EXPOSE 3000
EXPOSE 5000
EXPOSE 3001
EXPOSE 80

ENTRYPOINT /bin/zsh -c tmux

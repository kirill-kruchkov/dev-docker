FROM ubuntu:latest

# UPKEEPING

# RUN echo "deb http://deb.torproject.org/torproject.org xenial main" >> /etc/apt/sources.list \
  # && echo "deb-src http://deb.torproject.org/torproject.org xenial main" >> /etc/apt/sources.list

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


# Install basic PACKAGES

RUN apt-fast install --yes --quiet --no-install-recommends \
	sudo man less zsh ca-certificates \
	build-essential cmake \
  autogen automake libssl-dev libevent-dev libncurses5-dev pkg-config libtool \
	curl wget \
	git tig silversearcher-ag \
	python python-pip python3 \
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

## Vim

COPY dotfiles/vim/.vimrc /home/void
RUN apt-fast install --yes --quiet --no-install-recommends vim \
  && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
  && vim +PluginInstall +qall

## TMUX

RUN cd /home/void \
  && git clone https://github.com/tmux/tmux.git \
  && cd tmux \
	&& sh autogen.sh \
	&& ./configure && make \
  && sudo make install
COPY dotfiles/tmux/.tmux.conf /home/void

## Ranger - TODO

#### RUN ...

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


# Setup node

RUN /bin/zsh -c 'source ~/.zshrc && nvm install v9.11.0 && nvm alias defaul v9.11.0 && nvm use default'


# Install global NPM packages

RUN /bin/zsh -c 'source ~/.zshrc && npm i -g \
  @storybook/cli	\
  lighthouse\
  cpx\
  ngrok\
  node-gyp\
  create-react-app\
  node-inspect\
  lerna\
  yo\
  graphql-cli \
  gatsby-cli\
  ocaml-language-server'


# GO!

EXPOSE 8000
EXPOSE 3000
EXPOSE 3001
EXPOSE 80

ENTRYPOINT ["/bin/zsh", "-c", "tmux"]

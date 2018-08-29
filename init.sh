# NVM
nvm install v9.11.2
nvm alias default v9.11.2
nvm use default

# Global NPM modules
npm i -g npm
npm i -g \
 @storybook/cli	\
 lighthouse \
 cpx \
 ngrok \
 node-gyp \
 create-react-app \
 node-inspect \
 lerna \
 yo \
 graphql-cli \
 gatsby-cli \
 reason-cli@3.2.0-linux \
 bs-platform

# Vim
vim +PluginInstall +qall
cd ~/.vim/bundle/youcompleteme && ./install.py --js-completer --tern-completer
mkdir ~/.vim/autoload/airline/themes
cp ~/.vim/bundle/onehalf/vim/autoload/airline/themes/onehalfdark.vim ~/.vim/autoload/airline/themes
mkdir ~/.vim/colors && cp ~/.vim/bundle/onehalf/vim/colors/onehalfdark.vim ~/.vim/colors


#!/bin/sh
echo cd ./tintin \
  && echo "#var playername $1" | cat - config.tin > temp && mv temp config.tin \
  && /usr/local/bin/tt++ config.tin \
  && /bin/sh

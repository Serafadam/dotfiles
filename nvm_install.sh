#!/usr/bin/env bash
mkdir $NVM_DIR
export NODE_VERSION=24 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION"
. $NVM_DIR/nvm.sh
nvm install 20 && nvm use 20

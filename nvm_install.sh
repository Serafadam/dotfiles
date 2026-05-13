#!/usr/bin/env bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.bashrc
nvm install 20 && nvm use 20

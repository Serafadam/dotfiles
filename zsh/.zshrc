# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'
export TERM=xterm-256color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# Path to your Oh My Zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git
	zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"
export $(dbus-launch)
export QT_SCREEN_SCALE_FACTORS=1
xhost +local:docker

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/adaser/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/adaser/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/adaser/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/adaser/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

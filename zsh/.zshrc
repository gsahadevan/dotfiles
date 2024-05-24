# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="avit"
ZSH_THEME="gsahadevan"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# After installing chromium 
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# Some minor scripts needed for nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# for linux
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Basic commands 
alias ouch="tail -50 ~/.zshrc"
alias code="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias hi="history | fzf-tmux -p --reverse"
alias so="source ~/.zshrc"
alias cl="clear"
alias lla="ls -ltra"
alias vim="nvim" # Remap vim to nvim

# some minor scripts for tmux
alias tsh="tmux split-window -h -p 50"
alias tsv="tmux split-window -v -p 50"
alias ide="tmux rename-window 'ide'; tmux split-window -v -p 15; tmux split-window -h -p 20"

# For git
alias gs="git status"
alias gp="git pull"

# brew install caarlos0/tap/timer
POMO_DEFAULT_TIME='5'
POMO_DEFAULT_TASK='work'
function pomo() {
    if [ -n "$1" ]
    then
        if [ -n "$2" ]
        then
            timer "$2"m -n "$1 for $2 mins" && afplay /System/Library/Sounds/Funk.aiff
        else
            timer 5m -n "$1 for $POMO_DEFAULT_TIME mins" && afplay /System/Library/Sounds/Funk.aiff
        fi 
    else
        timer 5m -n "$POMO_DEFAULT_TASK for $POMO_DEFAULT_TIME mins" && afplay /System/Library/Sounds/Funk.aiff
    fi
}

# add empty line before every prompt
# precmd() { print "" }

# tmux ide
ide () {
    # Use -d to allow the rest of the function to run
    tmux new-session -d -s dev
    # rename the current window to playground
    tmux rename-window playground
    # -d to prevent current window from changing
    tmux new-window -d -n editor
    tmux new-window -d -n servers
    tmux new-window -d -n git
    # -d to detach any other client 
    # (which there shouldn't be, since you just created the session).
    tmux attach-session -d -t dev
}

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

shopt -s expand_aliases

set -o vi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$HOME/dev/scripts"

# Source user-defined functions/aliases
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

eval "$(starship init bash)"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# multiline saved as a single line
shopt -s cmdhist

HISTSIZE=1000
HISTFILESIZE=2000

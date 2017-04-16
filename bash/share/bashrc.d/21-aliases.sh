alias Ls='ls -hl'
alias LS='ls -hla'
alias calm="echo \"I'm fine, thanks!\""

export LESS='SRM'
# M:long long prompt, S:do not wrap, R:raw colors
# may add F:one screen=>shutdown now, X:no clear, only with F
# systemd adds K:die on ^C, don't like it
export LESS1='FXSRM'
alias lessy="LESS='${LESS1}' less"
export SYSTEMD_LESS="${LESS}"

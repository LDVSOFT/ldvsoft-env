# M:long long prompt, S:do not wrap, R:raw colors
# may add F:one screen=>shutdown now, X:no clear (use only with F)
# systemd adds K:die on ^C, don't like it
export LESS='SRM'
export LESS1='SRMFX'
export SYSTEMD_LESS="${LESS}"
alias lessy="LESS='${LESS1}' less"

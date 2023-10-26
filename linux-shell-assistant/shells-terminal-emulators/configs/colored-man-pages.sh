# ...................................................
# +(BEGIN) STYLISH MAN - COLORED MAN PAGES+
#
man() {
    LESS_TERMCAP_mb=$'\e[01;31m'
    LESS_TERMCAP_md=$'\e[01;31m' \
                   LESS_TERMCAP_me=$'\e[0m' \
                   LESS_TERMCAP_se=$'\e[0m' \
                   LESS_TERMCAP_so=$'\e[45;93m' \
                   LESS_TERMCAP_ue=$'\e[0m' \
                   LESS_TERMCAP_us=$'\e[4;93m' \
                   command man "$@"
}

# man displays a percentage at the bottom
export MANPAGER='less -s -M +Gg'
#
# +(END) STYLISH MAN - COLORED MAN PAGES+
# ...................................................


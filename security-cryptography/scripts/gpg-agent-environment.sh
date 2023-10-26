#==========================================================
# GPG AGENT + SSH
#==========================================================
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# sugerido por la doc de gpg
export GPG_TTY="$(tty)"

# sugerido por la doc de gpg
#gpg-connect-agent /bye

gpg-connect-agent updatestartuptty /bye
#==========================================================
#==========================================================

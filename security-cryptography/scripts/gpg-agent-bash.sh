GPG_ENV="${HOME}/.gnupg/gpg-agent-environment.sh"

function configure_agent_gpg {
    source "${GPG_ENV}" > /dev/null
    # /usr/bin/ssh-add
}

if [ -f "${GPG_ENV}" ]; then
    configure_agent_gpg
fi

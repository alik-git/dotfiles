# Personal shell additions for work_mnv1.

_work_mnv1_set_stable_ssh_auth_sock() {
    local source_sock="${1:-}"
    local stable_sock="$HOME/.ssh/ssh_auth_sock"

    [ -n "$source_sock" ] || return 1
    if [ "$source_sock" = "$stable_sock" ]; then
        [ -S "$stable_sock" ] || return 1
        export SSH_AUTH_SOCK="$stable_sock"
        return 0
    fi
    [ -S "$source_sock" ] || return 1
    mkdir -p "$HOME/.ssh"
    ln -sfn "$source_sock" "$stable_sock"
    export SSH_AUTH_SOCK="$stable_sock"
}

if [ -n "${SSH_AUTH_SOCK:-}" ] && [ -S "$SSH_AUTH_SOCK" ]; then
    _work_mnv1_set_stable_ssh_auth_sock "$SSH_AUTH_SOCK"
elif [ -S "$HOME/.ssh/ssh_auth_sock" ]; then
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
fi

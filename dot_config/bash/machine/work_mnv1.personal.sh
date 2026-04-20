# Personal shell additions for work_mnv1.

_work_mnv1_is_shpool_ssh_auth_sock() {
    case "${1:-}" in
        /run/user/*/shpool/sessions/*/ssh-auth-sock.socket) return 0 ;;
        *) return 1 ;;
    esac
}

_work_mnv1_is_forwarded_ssh_auth_sock() {
    case "${1:-}" in
        /tmp/ssh-*/agent.*) return 0 ;;
        *) return 1 ;;
    esac
}

_work_mnv1_has_ssh_auth_identity() {
    local candidate_sock="${1:-}"

    [ -S "$candidate_sock" ] || return 1
    SSH_AUTH_SOCK="$candidate_sock" ssh-add -l >/dev/null 2>&1
}

_work_mnv1_set_stable_ssh_auth_sock() {
    local source_sock="${1:-}"
    local stable_sock="$HOME/.ssh/ssh_auth_sock"

    [ -n "$source_sock" ] || return 1
    if [ "$source_sock" = "$stable_sock" ]; then
        _work_mnv1_has_ssh_auth_identity "$stable_sock" || return 1
        export SSH_AUTH_SOCK="$stable_sock"
        return 0
    fi
    _work_mnv1_is_shpool_ssh_auth_sock "$source_sock" && return 1
    _work_mnv1_is_forwarded_ssh_auth_sock "$source_sock" || return 1
    _work_mnv1_has_ssh_auth_identity "$source_sock" || return 1
    mkdir -p "$HOME/.ssh"
    ln -sfn "$source_sock" "$stable_sock"
    export SSH_AUTH_SOCK="$stable_sock"
}

_work_mnv1_find_forwarded_ssh_auth_sock() {
    local candidate_sock

    for candidate_sock in /tmp/ssh-*/agent.*; do
        _work_mnv1_has_ssh_auth_identity "$candidate_sock" || continue
        printf '%s\n' "$candidate_sock"
        return 0
    done
    return 1
}

_work_mnv1_refresh_stable_ssh_auth_sock() {
    local recovered_sock

    if [ -n "${SSH_AUTH_SOCK:-}" ] && \
        _work_mnv1_is_forwarded_ssh_auth_sock "$SSH_AUTH_SOCK" && \
        _work_mnv1_has_ssh_auth_identity "$SSH_AUTH_SOCK"; then
        _work_mnv1_set_stable_ssh_auth_sock "$SSH_AUTH_SOCK" && return 0
    fi
    if _work_mnv1_has_ssh_auth_identity "$HOME/.ssh/ssh_auth_sock"; then
        export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
        return 0
    fi
    recovered_sock="$(_work_mnv1_find_forwarded_ssh_auth_sock)" || return 1
    _work_mnv1_set_stable_ssh_auth_sock "$recovered_sock"
}

fixssha() {
    local recovered_sock

    if _work_mnv1_has_ssh_auth_identity "$HOME/.ssh/ssh_auth_sock"; then
        export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
        printf 'Using stable SSH agent socket: %s\n' "$SSH_AUTH_SOCK"
        return 0
    fi

    if [ -n "${SSH_AUTH_SOCK:-}" ] && \
        _work_mnv1_is_forwarded_ssh_auth_sock "$SSH_AUTH_SOCK" && \
        _work_mnv1_has_ssh_auth_identity "$SSH_AUTH_SOCK"; then
        _work_mnv1_set_stable_ssh_auth_sock "$SSH_AUTH_SOCK" || return 1
        printf 'Refreshed stable SSH agent socket from current shell: %s\n' "$SSH_AUTH_SOCK"
        return 0
    fi

    recovered_sock="$(_work_mnv1_find_forwarded_ssh_auth_sock)" || {
        printf 'Unable to find a live forwarded SSH agent under /tmp/ssh-*/agent.*\n' >&2
        return 1
    }
    _work_mnv1_set_stable_ssh_auth_sock "$recovered_sock" || return 1
    printf 'Refreshed stable SSH agent socket: %s -> %s\n' \
        "$HOME/.ssh/ssh_auth_sock" "$recovered_sock"
}

_work_mnv1_refresh_stable_ssh_auth_sock >/dev/null 2>&1 || true

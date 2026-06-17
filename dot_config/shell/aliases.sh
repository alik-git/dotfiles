# Shared aliases and shell functions.

alias spp='shpool'
alias spl='shpool list'
alias pqst='pueue status columns=id,status,label,start,end'
alias qs='quick-status'
alias wl='worklogs'
alias ca='conda activate'
alias updatecodex='npm install -g @openai/codex@latest'

spa() {
    if type _work_machine_refresh_stable_ssh_auth_sock >/dev/null 2>&1; then
        _work_machine_refresh_stable_ssh_auth_sock >/dev/null 2>&1 || true
    fi
    command shpool attach "$@"
}

pop() {
    local rc_file="${ALI_SHELL_RC:-$HOME/.bashrc}"

    if . "$rc_file"; then
        printf 'Sourced %s successfully.\n' "$rc_file"
    else
        local status=$?
        printf 'Sourcing %s failed with status %d.\n' "$rc_file" "$status" >&2
        return "$status"
    fi
}

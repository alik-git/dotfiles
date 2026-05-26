# Shell aliases sourced from ~/.bashrc.

# Shpool convenience aliases.
alias spp='shpool'
alias spl='shpool list'

# Pueue queue status shortcut.
alias pqst='pueue status columns=id,status,label,start,end'

# Quick workspace status shortcut.
alias qs='quick-status'

spa() {
    if declare -F _work_mnv1_refresh_stable_ssh_auth_sock >/dev/null 2>&1; then
        _work_mnv1_refresh_stable_ssh_auth_sock >/dev/null 2>&1 || true
    fi
    command shpool attach "$@"
}

# Reload the current interactive shell config.
pop() {
    if source "$HOME/.bashrc"; then
        printf 'Ran source ~/.bashrc successfully.\n'
    else
        local status=$?
        printf 'source ~/.bashrc failed with status %d.\n' "$status" >&2
        return "$status"
    fi
}

# Conda environment activation shortcut.
alias ca='conda activate'

# Update the global Codex CLI installed via npm.
alias updatecodex='npm install -g @openai/codex@latest'

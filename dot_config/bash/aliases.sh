# Shell aliases sourced from ~/.bashrc.

# Shpool convenience aliases.
alias spp='shpool'
alias spl='shpool list'

spa() {
    if declare -F _work_mnv1_refresh_stable_ssh_auth_sock >/dev/null 2>&1; then
        _work_mnv1_refresh_stable_ssh_auth_sock >/dev/null 2>&1 || true
    fi
    command shpool attach "$@"
}

# Reload the current interactive shell config.
alias pop='source ~/.bashrc'

# Conda environment activation shortcut.
alias ca='conda activate'

# Update the global Codex CLI installed via npm.
alias updatecodex='npm install -g @openai/codex@latest'

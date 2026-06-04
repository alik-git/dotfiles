# Shared interactive shell setup used across Bash and zsh.

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d /opt/homebrew/bin ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

export CLICOLOR="${CLICOLOR:-1}"

ali_git_branch() {
    git symbolic-ref --short HEAD 2>/dev/null
}

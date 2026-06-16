# Machine-specific shell additions for personal Linux machines.
#
# Holds both manual profile config and tool-managed init (conda, nvm, ...).
# If an installer appends init to ~/.bashrc, move it into this file instead.

repairdiscord() {
    local config_home discord_dir latest_app
    config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
    discord_dir="$config_home/discord"

    if [ ! -d "$discord_dir" ]; then
        return 0
    fi

    latest_app=$(
        find "$discord_dir" -maxdepth 1 -mindepth 1 -type d -name 'app-*' 2>/dev/null \
            | sort -V \
            | tail -n 1
    )

    if [ -n "$latest_app" ] && [ -x "$latest_app/Discord" ]; then
        ln -sfn "$latest_app/Discord" "$discord_dir/Discord"
    fi
}

updatediscord() {
    if pgrep -x Discord >/dev/null 2>&1 || pgrep -x discord >/dev/null 2>&1; then
        echo "Discord is running. Close it and run updatediscord again." >&2
        return 1
    fi

    cd /tmp || return 1
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb" && \
        sudo apt install ./discord.deb && \
        repairdiscord
}

# --- Tool-managed init (installers may append below; keep it in this file) ---

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

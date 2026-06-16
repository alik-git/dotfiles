# Personal shell additions for personal Linux machines.

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

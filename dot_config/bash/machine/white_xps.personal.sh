# Personal shell additions for white_xps.

updatediscord() {
    if pgrep -x Discord >/dev/null 2>&1 || pgrep -x discord >/dev/null 2>&1; then
        echo "Discord is running. Close it and run updatediscord again." >&2
        return 1
    fi

    cd /tmp || return 1
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb" && \
        sudo apt install ./discord.deb
}

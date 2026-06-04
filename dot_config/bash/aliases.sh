# Bash wrapper for shared shell aliases.
if [ -f "$HOME/.config/shell/aliases.sh" ]; then
    ALI_SHELL_RC="$HOME/.bashrc"
    . "$HOME/.config/shell/aliases.sh"
fi

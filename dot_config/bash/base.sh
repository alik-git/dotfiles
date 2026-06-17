# Base shell layer: loaded on every machine.
#
# Holds universal, non-sensitive setup and tool-managed init (conda, nvm, ...)
# that is identical everywhere. Machine- or task-specific config belongs in the
# os/task/machine layers, not here.

# Keep interactive terminals colorful even if a parent process exported NO_COLOR.
unset NO_COLOR
export CLICOLOR=1

# --- Tool-managed init (installers may append shared init here) ---

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

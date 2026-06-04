# zsh prompt matching the shared Bash prompt layout.

autoload -Uz colors
colors
setopt PROMPT_SUBST

ali_zsh_git_branch() {
    local branch
    branch="$(ali_git_branch)"
    if [ -n "$branch" ]; then
        printf '(%s)' "$branch"
    fi
}

PROMPT='%F{green}%n@%m%f %F{cyan}[%D{%I:%M:%S%p} %D{%d/%m/%Y}]%f:
%F{white}$(ali_zsh_git_branch)%f %F{blue}%~/%f
$ '

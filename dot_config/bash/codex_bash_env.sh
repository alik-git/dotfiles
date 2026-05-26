# Guarded BASH_ENV dispatcher for Codex command tool shells.
# This file must stay quiet unless quick-status prints a reminder after a
# matching top-level Codex command.
__quick_status_codex_bash_env_init() {
    [ -n "${BASH_VERSION:-}" ] || return 0
    [ -n "${CODEX_THREAD_ID:-}" ] || return 0
    [ "${CODEX_CI:-}" = "1" ] || return 0
    [ -n "${BASH_EXECUTION_STRING:-}" ] || return 0
    case "$BASH_EXECUTION_STRING" in
        *__CODEX_SNAPSHOT*|*/.codex/shell_snapshots/*) return 0 ;;
    esac
    [ "${QUICK_STATUS_CODEX_REMINDERS_LOADED:-0}" != "1" ] || return 0

    export QUICK_STATUS_CODEX_REMINDERS_LOADED=1

    if command -v quick-status >/dev/null 2>&1; then
        if __qs_codex_init="$(quick-status reminders init bash --context codex 2>/dev/null)"; then
            eval "$__qs_codex_init"
        fi
    fi
    unset __qs_codex_init
}
__quick_status_codex_bash_env_init
unset -f __quick_status_codex_bash_env_init

#!/usr/bin/env bash
# Source this file for an interactive shell. Agents should prefer bin/ai-python.

AI_SCRATCH_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export AI_SCRATCH_ROOT
AI_SCRATCH_CACHE_DIR="${AI_SCRATCH_CACHE_DIR:-${TMPDIR:-/tmp}/ai-scratch-cache-${UID}}"
export AI_SCRATCH_CACHE_DIR
export UV_CACHE_DIR="${UV_CACHE_DIR:-$AI_SCRATCH_CACHE_DIR/uv}"
export MPLCONFIGDIR="${MPLCONFIGDIR:-$AI_SCRATCH_CACHE_DIR/matplotlib}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$AI_SCRATCH_CACHE_DIR/xdg}"
export VIRTUAL_ENV="$AI_SCRATCH_ROOT/.venv"
export PATH="$VIRTUAL_ENV/bin:$PATH"

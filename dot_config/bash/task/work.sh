# Task layer: work machines.
#
# Shared setup for any work machine, regardless of OS or which specific box.
# Generic, non-sensitive values only.

# Keep pre-commit's hook cache somewhere writable in sandboxed environments.
export WORK_CACHE_HOME="${WORK_CACHE_HOME:-$HOME/Projects/.cache}"
export PRE_COMMIT_HOME="${PRE_COMMIT_HOME:-${WORK_CACHE_HOME}/pre-commit}"

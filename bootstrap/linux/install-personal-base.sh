#!/usr/bin/env bash

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APT_PACKAGES_FILE="${SCRIPT_DIR}/ubuntu-apt-packages.txt"
MINICONDA_DIR="${HOME}/miniconda3"
NVM_DIR="${HOME}/.nvm"

had_failure=0

log() {
    printf '[bootstrap] %s\n' "$*"
}

warn() {
    printf '[bootstrap] warning: %s\n' "$*" >&2
}

fail_step() {
    printf '[bootstrap] error: %s\n' "$*" >&2
    had_failure=1
}

have_cmd() {
    command -v "$1" >/dev/null 2>&1
}

read_apt_packages() {
    mapfile -t APT_PACKAGES < <(sed -e 's/#.*$//' -e '/^[[:space:]]*$/d' "${APT_PACKAGES_FILE}")
}

install_apt_packages() {
    local missing_packages=()
    local pkg

    if ! have_cmd apt-get; then
        warn "apt-get is not available on this machine. Skipping Ubuntu/Debian package installation."
        return 0
    fi

    read_apt_packages

    for pkg in "${APT_PACKAGES[@]}"; do
        if ! dpkg-query -W -f='${Status}\n' "${pkg}" 2>/dev/null | grep -q "install ok installed"; then
            missing_packages+=("${pkg}")
        fi
    done

    if [ "${#missing_packages[@]}" -eq 0 ]; then
        log "All requested apt packages are already installed."
        return 0
    fi

    log "Missing apt packages: ${missing_packages[*]}"

    if ! have_cmd sudo; then
        fail_step "sudo is not installed, so the missing apt packages could not be installed."
        return 0
    fi

    if ! sudo -v; then
        fail_step "sudo authentication failed or this account does not have sudo access. Apt packages were not installed."
        return 0
    fi

    if ! sudo apt-get update; then
        fail_step "apt-get update failed."
        return 0
    fi

    if ! sudo apt-get install -y "${missing_packages[@]}"; then
        fail_step "apt package installation failed."
        return 0
    fi

    log "Installed missing apt packages successfully."
}

install_miniconda() {
    local os_name=""
    local arch=""
    local installer_name=""
    local installer_url=""
    local installer_path=""

    if [ -x "${MINICONDA_DIR}/bin/conda" ] || have_cmd conda; then
        log "Miniconda or conda is already available. Skipping Miniconda install."
        return 0
    fi

    os_name="$(uname -s)"
    arch="$(uname -m)"

    case "${os_name}" in
        Linux)
            case "${arch}" in
                x86_64) installer_name="Miniconda3-latest-Linux-x86_64.sh" ;;
                aarch64|arm64) installer_name="Miniconda3-latest-Linux-aarch64.sh" ;;
                *) fail_step "Unsupported Linux architecture for Miniconda installer: ${arch}"; return 0 ;;
            esac
            ;;
        Darwin)
            case "${arch}" in
                x86_64) installer_name="Miniconda3-latest-MacOSX-x86_64.sh" ;;
                arm64) installer_name="Miniconda3-latest-MacOSX-arm64.sh" ;;
                *) fail_step "Unsupported macOS architecture for Miniconda installer: ${arch}"; return 0 ;;
            esac
            ;;
        *)
            fail_step "Unsupported operating system for Miniconda installer: ${os_name}"
            return 0
            ;;
    esac

    if ! have_cmd curl; then
        fail_step "curl is required to download Miniconda, but it is not installed."
        return 0
    fi

    installer_url="https://repo.anaconda.com/miniconda/${installer_name}"
    installer_path="$(mktemp)"

    log "Downloading Miniconda installer from ${installer_url}"
    if ! curl -fsSL "${installer_url}" -o "${installer_path}"; then
        rm -f "${installer_path}"
        fail_step "Failed to download Miniconda installer."
        return 0
    fi

    if ! bash "${installer_path}" -b -p "${MINICONDA_DIR}"; then
        rm -f "${installer_path}"
        fail_step "Miniconda installation failed."
        return 0
    fi

    rm -f "${installer_path}"
    log "Installed Miniconda to ${MINICONDA_DIR}"
    log "Next step if desired: ${MINICONDA_DIR}/bin/conda init bash"
}

install_nvm() {
    local latest_tag=""

    if [ -s "${NVM_DIR}/nvm.sh" ]; then
        log "nvm is already installed at ${NVM_DIR}. Skipping nvm install."
        return 0
    fi

    if ! have_cmd git; then
        fail_step "git is required to install nvm, but it is not installed."
        return 0
    fi

    rm -rf "${NVM_DIR}"
    if ! git clone https://github.com/nvm-sh/nvm.git "${NVM_DIR}"; then
        fail_step "Failed to clone the nvm repository."
        return 0
    fi

    latest_tag="$(
        cd "${NVM_DIR}" &&
        git checkout "$(git describe --abbrev=0 --tags --match 'v[0-9]*' "$(git rev-list --tags --max-count=1)")"
    )" || {
        fail_step "Failed to check out the latest nvm release tag."
        return 0
    }

    log "Installed nvm to ${NVM_DIR}"
    log "Next step if desired: add nvm init lines to your shell config, then run 'nvm install node' for the latest Node release."
}

main() {
    log "Starting personal Linux bootstrap."
    install_apt_packages
    install_miniconda
    install_nvm

    if [ "${had_failure}" -ne 0 ]; then
        warn "Bootstrap finished with one or more failures. Review the messages above."
        exit 1
    fi

    log "Bootstrap finished successfully."
}

main "$@"

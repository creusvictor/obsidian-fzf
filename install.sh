#!/usr/bin/env bash

set -euo pipefail

# obsidian-fzf installer
# Usage: curl -fsSL https://raw.githubusercontent.com/creusvictor/obsidian-fzf/main/install.sh | bash

REPO="creusvictor/obsidian-fzf"
SCRIPT_NAME="obsidian-fzf"
RAW_URL="https://raw.githubusercontent.com/${REPO}/main/${SCRIPT_NAME}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

info()    { echo -e "${BOLD}[obsidian-fzf]${NC} $*"; }
success() { echo -e "${GREEN}[obsidian-fzf]${NC} $*"; }
warn()    { echo -e "${YELLOW}[obsidian-fzf]${NC} $*"; }
error()   { echo -e "${RED}[obsidian-fzf]${NC} $*" >&2; }

# Determine install directory
detect_install_dir() {
    # Prefer user-local install if ~/.local/bin exists or if not root
    if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
        echo "/usr/local/bin"
    elif [[ -d "$HOME/.local/bin" ]]; then
        echo "$HOME/.local/bin"
    else
        echo "$HOME/.local/bin"
    fi
}

# Check if a command is available
has() { command -v "$1" &>/dev/null; }

# Check required dependencies
check_dependencies() {
    local missing=()
    for dep in fzf rg bat; do
        if ! has "$dep"; then
            missing+=("$dep")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        warn "Missing dependencies: ${missing[*]}"
        echo ""
        echo "  Install them with:"
        echo ""
        if has apt-get; then
            echo "    sudo apt install fzf ripgrep bat"
        elif has pacman; then
            echo "    sudo pacman -S fzf ripgrep bat"
        elif has dnf; then
            echo "    sudo dnf install fzf ripgrep bat"
        elif has brew; then
            echo "    brew install fzf ripgrep bat"
        else
            echo "    fzf:     https://github.com/junegunn/fzf"
            echo "    ripgrep: https://github.com/BurntSushi/ripgrep"
            echo "    bat:     https://github.com/sharkdp/bat"
        fi
        echo ""
        warn "Continuing installation — obsidian-fzf won't work until dependencies are installed."
    fi
}

main() {
    info "Installing ${SCRIPT_NAME}..."
    echo ""

    # Detect install directory
    local install_dir
    install_dir="${INSTALL_DIR:-$(detect_install_dir)}"

    # Create install dir if needed
    if [[ ! -d "$install_dir" ]]; then
        mkdir -p "$install_dir"
    fi

    local dest="${install_dir}/${SCRIPT_NAME}"

    # Download script
    info "Downloading from ${RAW_URL}..."
    if has curl; then
        curl -fsSL "$RAW_URL" -o "$dest"
    elif has wget; then
        wget -qO "$dest" "$RAW_URL"
    else
        error "Neither curl nor wget found. Please install one and try again."
        exit 1
    fi

    chmod +x "$dest"
    success "Installed to ${dest}"
    echo ""

    # Warn if install dir is not in PATH
    if [[ ":$PATH:" != *":${install_dir}:"* ]]; then
        warn "${install_dir} is not in your \$PATH."
        echo ""
        echo "  Add it by appending to your shell config:"
        echo ""
        echo "    echo 'export PATH=\"${install_dir}:\$PATH\"' >> ~/.bashrc"
        echo "    echo 'export PATH=\"${install_dir}:\$PATH\"' >> ~/.zshrc"
        echo ""
        echo "  Then reload your shell:"
        echo ""
        echo "    source ~/.bashrc   # or ~/.zshrc"
        echo ""
    fi

    # Check dependencies
    check_dependencies

    success "Done! Run 'obsidian-fzf' to get started."
}

main "$@"

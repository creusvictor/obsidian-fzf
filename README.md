# obsidian-fzf

Lightning-fast fuzzy search CLI for Obsidian Vaults with note preview and terminal editor integration.

## Features

- Ultra-fast fuzzy search powered by `fzf` and `ripgrep`
- Syntax-highlighted note preview with `bat`
- Preview scrolling with Ctrl+↑/↓ or Ctrl+u/d
- Opens notes in your `$EDITOR` with vault directory as working directory
- Flexible configuration with multiple sources

## Dependencies

Install the following tools before using `obsidian-fzf`:

```bash
# Ubuntu/Debian
sudo apt install fzf ripgrep bat

# Arch Linux
sudo pacman -S fzf ripgrep bat

# macOS (Homebrew)
brew install fzf ripgrep bat

# Fedora
sudo dnf install fzf ripgrep bat
```

Python 3 is also required (usually pre-installed).

## Installation

1. Clone this repository:

```bash
git clone https://github.com/your-username/obsidian-fzf.git
cd obsidian-fzf
```

2. Copy the script to a directory in your `$PATH`:

```bash
sudo cp obsidian-fzf /usr/local/bin/
sudo chmod +x /usr/local/bin/obsidian-fzf
```

Or create a symlink:

```bash
mkdir -p ~/.local/bin
ln -s "$(pwd)/obsidian-fzf" ~/.local/bin/obsidian-fzf
# Make sure ~/.local/bin is in your $PATH
```

## Configuration

Define your Obsidian vault path using any of these methods (in order of precedence):

### 1. Command-line argument (highest precedence)

```bash
obsidian-fzf /path/to/your/vault
```

### 2. Environment variable

```bash
export OBSIDIAN_VAULT="/path/to/your/vault"
obsidian-fzf
```

Add the `export` line to your `~/.bashrc` or `~/.zshrc` to make it permanent.

### 3. Configuration file

```bash
mkdir -p ~/.config/obsidian-fzf
echo "/path/to/your/vault" > ~/.config/obsidian-fzf/config
```

### 4. Default path (lowest precedence)

If nothing is configured, `~/Documents/ObsidianVault` will be used.

## Usage

Run the command:

```bash
obsidian-fzf
```

### Interface Controls

- **Enter**: Open note in your `$EDITOR` (Vim, Neovim, etc.) with vault directory as working directory
- **↑/↓**: Navigate between files
- **Ctrl+↑/↓**: Scroll preview (line by line)
- **Ctrl+u/d**: Scroll preview (full page)
- **Esc** or **Ctrl-c**: Exit

### Search

Simply type to search:

- Search by filename
- Fuzzy search - no need to type the complete name
- Use spaces to search for multiple terms

## Examples

```bash
# Basic usage with default configuration
obsidian-fzf

# Specify vault directly
obsidian-fzf ~/Documents/MyVault

# With environment variable
export OBSIDIAN_VAULT="$HOME/Dropbox/ObsidianNotes"
obsidian-fzf
```

## License

MIT

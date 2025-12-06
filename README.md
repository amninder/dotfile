# Dotfiles

Personal development environment configuration featuring Neovim, Tmux, and shell setups with a unified Gruvbox Dark theme.

## 🎨 Features

### Tmux Configuration
- **Gruvbox Dark Theme**: Professional color scheme matching Neovim
- **tmux-powerline**: Custom status bar with Nerd Font glyphs
- **System Monitoring**: Real-time CPU, memory, and load average display
- **Network Information**: LAN IP, WAN IP, and bandwidth monitoring
- **Weather Integration**: Current weather conditions in status bar
- **Vi-mode**: Vim-style keybindings for navigation and copy mode
- **Centered Window List**: Clean, organized window display
- **Custom Keybindings**: Intuitive prefix (`Ctrl+a`) and shortcuts

### Neovim Configuration
- **Modern Plugin Manager**: lazy.nvim for fast, lazy-loaded plugins
- **LSP Support**: Language Server Protocol for intelligent code completion
- **Treesitter**: Advanced syntax highlighting and code understanding
- **File Explorer**: nvim-tree for sidebar file navigation
- **Fuzzy Finding**: Telescope for quick file and content search
- **Gruvbox Theme**: Consistent colors with Tmux environment

### Shell Configuration
- **Bash**: Custom prompt with git integration, extensive aliases
- **Zsh**: Enhanced shell configuration
- **Git**: Comprehensive aliases and helper functions
- **Python Tools**: Enhanced pdb and ptpython configurations

### Testing Utilities
- **Nerd Fonts Test Suite**: Verify font installation and rendering
- **Three test levels**: Smoke test, Unicode ranges, and categorized icons
- **Automated installation**: Makefile targets for easy setup

## 📋 Requirements

### Essential
- **macOS** (Linux compatible with minor adjustments)
- **Neovim** >= 0.9.0
- **Tmux** >= 3.0
- **Git**
- **Nerd Font** (required for powerline glyphs and icons)

### Optional
- **Homebrew** (for easy font installation)
- **ifstat** (for bandwidth monitoring in tmux)
- **Node.js** (for some LSP servers)
- **Python 3** (for Python development features)

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/amninder/dotfile.git ~/dotfile
cd ~/dotfile
```

### 2. Install Nerd Fonts

Install fonts using Homebrew (recommended):

```bash
make install-fonts
```

Or manually download from [Nerd Fonts](https://www.nerdfonts.com/).

**Recommended fonts:**
- JetBrains Mono Nerd Font
- Fira Code Nerd Font
- Hack Nerd Font
- Meslo LG Nerd Font

### 3. Configure Your Terminal

**Set your terminal font to a Nerd Font:**

- **iTerm2**: Preferences → Profiles → Text → Font
- **Terminal.app**: Preferences → Profiles → Font → Change
- **VS Code**: Settings → Terminal › Integrated: Font Family

**Example:**
```
JetBrains Mono Nerd Font
```

### 4. Install Configuration Files

#### Option A: Symbolic Links (Recommended)

```bash
# Neovim
ln -s ~/dotfile/lua ~/.config/nvim/lua
ln -s ~/dotfile/init.lua ~/.config/nvim/init.lua

# Tmux
ln -s ~/dotfile/.tmux.conf ~/.tmux.conf
ln -s ~/dotfile/.config/tmux-powerline ~/.config/tmux-powerline

# Shell
ln -s ~/dotfile/.bash_profile ~/.bash_profile
ln -s ~/dotfile/.bashrc ~/.bashrc
ln -s ~/dotfile/.zshrc ~/.zshrc

# Git
ln -s ~/dotfile/.gitconfig ~/.gitconfig

# Python tools (optional)
ln -s ~/dotfile/.pdbrc ~/.pdbrc
ln -s ~/dotfile/.pdbrc.py ~/.pdbrc.py
ln -s ~/dotfile/.ptpython ~/.ptpython
```

#### Option B: Direct Copy

```bash
# Copy all configs
cp -r lua ~/.config/nvim/
cp init.lua ~/.config/nvim/
cp .tmux.conf ~/
cp -r .config/tmux-powerline ~/.config/
cp .bash_profile ~/.bash_profile
cp .bashrc ~/.bashrc
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
```

### 5. Install Tmux Plugin Manager (TPM)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 6. Install tmux-powerline

```bash
git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/plugins/tmux-powerline
```

### 7. Reload Configurations

```bash
# Reload shell
source ~/.bash_profile  # or source ~/.zshrc

# Start tmux and install plugins
tmux
# Press: Ctrl+a then I (capital i) to install plugins

# Start neovim (plugins install automatically)
nvim
```

## 🧪 Testing

### Verify Nerd Font Installation

```bash
# Quick smoke test
make test-smoke

# Comprehensive Unicode range test
make test-unicode

# Categorized icon sets test
make test-icons

# Run all tests
make test-all
```

If you see boxes (□) or missing icons, ensure:
1. A Nerd Font is installed
2. Your terminal is configured to use it
3. Terminal is restarted after font changes

## 🛠️ Dev Utilities Installation

Install modern CLI utilities to enhance your development workflow across macOS and Linux.

### Quick Start

```bash
# Install all dev utilities
make install-dev-utils
```

### Installed Utilities

| Tool | Description | Usage |
|------|-------------|-------|
| **zoxide** | Smart directory navigation (cd replacement) | `z <partial-path>` |
| **fzf** | Fuzzy finder for files and command history | `CTRL-R` (history), `CTRL-T` (files) |
| **ripgrep** | Ultra-fast recursive search (grep alternative) | `rg <pattern>` |
| **bat** | Syntax-highlighted file viewer (cat alternative) | `bat <file>` |
| **eza** | Modern ls replacement with colors and icons | `eza -l` or `exa -l` |
| **fd** | Simple, fast alternative to find | `fd <pattern>` |
| **jq** | Command-line JSON processor | `echo '{"key":"value"}' | jq` |
| **gh** | GitHub CLI for working with GitHub from terminal | `gh pr list` |
| **ag** | The Silver Searcher - fast code searching tool | `ag <pattern>` |

### Package Manager Support

Automatic detection and installation across:
- **macOS**: Homebrew
- **Debian/Ubuntu**: apt-get
- **RHEL/CentOS/Fedora**: dnf/yum
- **Arch Linux**: pacman
- **Alpine Linux**: apk

Check detected package manager:
```bash
make detect-package-manager
```

### Special Notes

**zoxide**: Not available in default repositories for most Linux distributions. The installer will provide manual installation instructions:
```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

**eza vs exa**: On older distributions, `eza` may not be available and will fall back to `exa`.

**fd**: Package name varies by distribution (`fd-find` on Debian/Ubuntu, `fd` elsewhere).

### Docker Testing

Test installation across multiple Linux distributions without affecting your system:

```bash
# Start test containers
make test-docker-setup

# Run installation tests on all distributions
make test-docker-install

# Stop containers
make test-docker-teardown

# Clean up completely (removes volumes)
make test-docker-clean
```

**Tested distributions**:
- Ubuntu 22.04 LTS
- Debian 12 (Bookworm)
- Fedora 39
- CentOS Stream 9
- Arch Linux (rolling)
- Alpine Linux 3.19

### Shell Integration

After installation, add these to your `.zshrc` or `.bashrc`:

```bash
# zoxide (smart cd)
eval "$(zoxide init zsh)"  # or 'bash' for bash

# fzf key bindings (already sourced if installed via package manager)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

**Aliases** (optional):
```bash
alias cat='bat'
alias ls='eza'
alias ll='eza -l'
alias la='eza -la'
alias find='fd'
```

### Troubleshooting

**Issue**: Package installation fails
- **Solution**: Check your internet connection and package manager cache
- Run `brew update` (macOS) or `sudo apt-get update` (Debian/Ubuntu)

**Issue**: Permission denied errors
- **Solution**: Linux installations require sudo privileges
- Ensure your user is in the sudoers file

**Issue**: Docker tests fail
- **Solution**: Ensure Docker and Docker Compose are installed and running
- Check Docker daemon: `docker ps`

## ⚙️ Configuration

### Tmux Customization

#### Change Weather Location

Edit `.config/tmux-powerline/config.sh`:

```bash
# Find your location ID from https://www.yr.no/
export TMUX_POWERLINE_SEG_WEATHER_LOCATION="11554"
```

#### Modify Status Bar Segments

Edit `.config/tmux-powerline/themes/gruvbox-dark.sh`:

```bash
# Left side segments
TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    "tmux_session_info ${GRUVBOX_YELLOW} ${GRUVBOX_BG0}" \
    "lan_ip ${GRUVBOX_BLUE} ${GRUVBOX_BG0}" \
    # Add or remove segments here
)

# Right side segments
TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    "load ${GRUVBOX_BG2} ${GRUVBOX_RED}" \
    # Add or remove segments here
)
```

#### Customize Colors

Modify color variables in `.config/tmux-powerline/themes/gruvbox-dark.sh`:

```bash
readonly GRUVBOX_BG0="235"      # Background
readonly GRUVBOX_FG1="223"      # Foreground
readonly GRUVBOX_YELLOW="214"   # Accent colors
# ... more colors
```

### Neovim Customization

#### Add New Plugins

Edit `lua/custom/plugins/` and add new plugin files:

```lua
-- lua/custom/plugins/my-plugin.lua
return {
  'author/plugin-name',
  config = function()
    -- Plugin configuration
  end
}
```

#### Modify Theme

Edit theme settings in your init.lua or plugin config.

### Git Configuration

Update user information in `.gitconfig`:

```ini
[user]
    email = your-email@example.com
    name = Your Name
```

## 📖 Usage

### Tmux Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+a` | Prefix key (instead of Ctrl+b) |
| `Prefix + c` | Create new window |
| `Prefix + ,` | Rename window |
| `Prefix + h/j/k/l` | Navigate panes (vim-style) |
| `Prefix + r` | Reload tmux configuration |
| `Prefix + [` | Enter copy mode (use vi keys) |
| `Prefix + ]` | Paste from buffer |

### Neovim Quick Start

Launch Neovim and plugins will auto-install on first run:

```bash
nvim
```

Common commands:
- `:Lazy` - View plugin status
- `:Mason` - Manage LSP servers
- `:Telescope find_files` - Fuzzy file finder
- `:NvimTreeToggle` - Toggle file explorer

### Bash Aliases

Useful aliases from `.bash_profile`:

```bash
ll          # Detailed file listing
la          # List all files
ducks       # Show largest files/folders
c           # Clear screen
up          # Go up one directory
resrc       # Reload .bashrc
```

### Git Aliases

From `.gitconfig`:

```bash
git lg      # Beautiful commit graph
git ll      # Detailed log with changes
git st      # Short status
git br      # Branch list
git co      # Checkout
git ci      # Commit
```

## 🎯 Makefile Targets

### Font & Testing
| Target | Description |
|--------|-------------|
| `make install-fonts` | Install Nerd Fonts via Homebrew |
| `make test-smoke` | Quick Nerd Font verification |
| `make test-unicode` | Comprehensive Unicode range test |
| `make test-icons` | Categorized icon sets test |
| `make test-all` | Run all font tests |

### Dev Utilities
| Target | Description |
|--------|-------------|
| `make detect-package-manager` | Detect and display system package manager |
| `make install-dev-utils` | Install dev utilities (zoxide, fzf, ripgrep, bat, eza, fd, jq, gh, ag) |

### Docker Testing
| Target | Description |
|--------|-------------|
| `make test-docker-setup` | Start Docker test containers (all Linux distros) |
| `make test-docker-install` | Test installation in all Docker containers |
| `make test-docker-teardown` | Stop and remove Docker containers |
| `make test-docker-clean` | Remove containers and volumes (destructive) |

### Cleanup
| Target | Description |
|--------|-------------|
| `make clean` | Clean up test artifacts and symlinks |

## 🔧 Troubleshooting

### Powerline Symbols Not Showing

1. **Verify Nerd Font is installed:**
   ```bash
   make test-smoke
   ```

2. **Check terminal font setting:**
   - Must be set to a Nerd Font (e.g., "JetBrains Mono Nerd Font")
   - Restart terminal after changing

3. **Verify tmux-powerline config:**
   ```bash
   export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"
   ```

### Tmux Status Bar Not Updating

1. **Reload tmux configuration:**
   ```bash
   tmux source-file ~/.tmux.conf
   ```

2. **Check tmux-powerline installation:**
   ```bash
   ls ~/.tmux/plugins/tmux-powerline
   ```

3. **Verify segments are executable:**
   ```bash
   chmod +x ~/.tmux/plugins/tmux-powerline/segments/*
   ```

### Neovim Plugins Not Loading

1. **Lazy.nvim sync:**
   ```vim
   :Lazy sync
   ```

2. **Check for errors:**
   ```vim
   :Lazy log
   ```

3. **Clean and reinstall:**
   ```bash
   rm -rf ~/.local/share/nvim
   nvim
   ```

### Network Segments Not Showing

1. **Install ifstat for bandwidth:**
   ```bash
   brew install ifstat
   ```

2. **Set interface in config:**
   Edit `.config/tmux-powerline/config.sh`:
   ```bash
   export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE="en0"
   ```

## 📚 File Structure

```
dotfile/
├── .config/
│   └── tmux-powerline/
│       ├── config.sh              # Powerline configuration
│       └── themes/
│           └── gruvbox-dark.sh    # Custom theme
├── .tests/
│   ├── smoke-test.sh              # Quick font test
│   ├── unicode-range-test.sh      # Unicode ranges
│   ├── icon-sets-test.sh          # Categorized icons
│   └── README.md                  # Test documentation
├── lua/
│   └── custom/
│       └── plugins/               # Neovim plugins
├── .bash_profile                  # Bash configuration
├── .bashrc                        # Bash runtime config
├── .gitconfig                     # Git configuration
├── .gitignore                     # Git ignore rules
├── .pdbrc                         # Python debugger config
├── .pdbrc.py                      # Python debugger config (pdb++)
├── .ptpython/                     # Enhanced Python REPL
├── .tmux.conf                     # Tmux configuration
├── .zshrc                         # Zsh configuration
├── init.lua                       # Neovim entry point
├── Makefile                       # Build and test targets
└── README.md                      # This file
```

## 🎨 Color Scheme Reference

### Gruvbox Dark Palette

```
Background:  #282828 (dark0_hard)
             #3c3836 (dark0)
             #504945 (dark1)

Foreground:  #ebdbb2 (light1)
             #fbf1c7 (light0)

Red:         #fb4934 (bright_red)
Green:       #b8bb26 (bright_green)
Yellow:      #fabd2f (bright_yellow)
Blue:        #83a598 (bright_blue)
Purple:      #d3869b (bright_purple)
Aqua:        #8ec07c (bright_aqua)
Orange:      #fe8019 (bright_orange)
```

## 🤝 Contributing

This is a personal dotfiles repository, but suggestions and improvements are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

This configuration is provided as-is for personal use. Feel free to adapt and modify for your own needs.

## 🙏 Acknowledgments

- [Gruvbox](https://github.com/morhetz/gruvbox) - Color scheme
- [tmux-powerline](https://github.com/erikw/tmux-powerline) - Status bar framework
- [Nerd Fonts](https://www.nerdfonts.com/) - Iconic font aggregator
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Neovim](https://neovim.io/) - Hyperextensible Vim-based text editor

## 📧 Contact

For questions or issues, please open an issue on GitHub.

---

**Happy coding! 🚀**

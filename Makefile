.PHONY: install-nvim install-nvim-plugins update clean backup install-fonts install-brew install-python install-dev-tools link unlink purge-nvim test-nerd-fonts test-smoke test-unicode test-icons test-all help

NVIM_DIR := $(HOME)/.config/nvim
BACKUP_DIR := $(HOME)/.config/nvim-backup-$(shell date +%Y%m%d-%H%M%S)

# Detect OS
UNAME_S := $(shell uname -s)

# Default Nerd Fonts to install (can be overridden)
NERD_FONTS ?= font-jetbrains-mono-nerd-font font-fira-code-nerd-font font-hack-nerd-font font-meslo-lg-nerd-font

# Python packages to install via Homebrew
PYTHON_PKGS := \
	python-lsp-server \
	virtualenvwrapper

# Development tools to install via Homebrew
DEV_TOOLS := \
	terraform-ls \
	typescript-language-server

# Color printing function
define print_colored
@_msg=$(1); \
_color=$(if $(2),$(2),green); \
case $$_color in \
	red) printf '\033[1;31m%s\033[0m\n' "$$_msg" ;; \
	green) printf '\033[1;32m%s\033[0m\n' "$$_msg" ;; \
	yellow) printf '\033[1;33m%s\033[0m\n' "$$_msg" ;; \
	cyan) printf '\033[1;36m%s\033[0m\n' "$$_msg" ;; \
	blue) printf '\033[1;34m%s\033[0m\n' "$$_msg" ;; \
	plain) printf '%s\n' "$$_msg" ;; \
	*) printf '\033[1;32m%s\033[0m\n' "$$_msg" ;; \
esac
endef

# Help menu item printing function (bold command + white description)
define print_help_item
@_cmd=$(1); \
_desc=$(2); \
_color=$(if $(3),$(3),default); \
case $$_color in \
	red) printf '\033[1;31m%-25s\033[0m%s\n' "$$_cmd" "$$_desc" ;; \
	*) printf '\033[1m%-25s\033[0m%s\n' "$$_cmd" "$$_desc" ;; \
esac
endef

help:
	@$(call print_colored,"Neovim Configuration Management","cyan")
	@$(call print_colored,"================================","cyan")
	@$(call print_help_item,"install-nvim","- Install Neovim (macOS: via brew)")
	@$(call print_help_item,"install-nvim-plugins","- Install/sync all plugins via lazy.nvim")
	@$(call print_help_item,"update","- Update all plugins to latest versions")
	@$(call print_help_item,"clean","- Clean plugin cache and unused plugins")
	@$(call print_help_item,"backup","- Backup current configuration")
	@$(call print_help_item,"link","- Create symlink from current directory to ~/.config/nvim")
	@$(call print_help_item,"unlink","- Remove symlink from ~/.config/nvim (safe)")
	@$(call print_help_item,"purge-nvim","- Complete removal of Neovim and all data","red")
	@$(call print_help_item,"install-fonts","- Install Nerd Fonts (macOS: via brew)")
	@echo ""
	@$(call print_colored,"Testing:","yellow")
	@$(call print_help_item,"test-nerd-fonts","- Run smoke test for basic Nerd Font icons")
	@$(call print_help_item,"test-smoke","- Run basic smoke test (same as test-nerd-fonts)")
	@$(call print_help_item,"test-unicode","- Test Unicode ranges with hex codes (comprehensive)")
	@$(call print_help_item,"test-icons","- Test all icon sets (comprehensive, categorized)")
	@$(call print_help_item,"test-all","- Run all Nerd Font tests")
	@echo ""
	@$(call print_colored,"System Tools:","yellow")
	@$(call print_help_item,"install-brew","- Install Homebrew (macOS only)")
	@$(call print_help_item,"install-python","- Install Python development tools via Homebrew")
	@$(call print_help_item,"install-dev-tools","- Install development tools (terraform-ls and typescript-language-server)")
	@echo ""
	@$(call print_colored,"Environment Variables:","yellow")
	@$(call print_colored,"  NERD_FONTS   - Space-separated list of fonts to install","cyan")
	@$(call print_colored,"                 Default: JetBrains Mono | Fira Code | Hack | Meslo LG","plain")
	@$(call print_colored,"  PYTHON_PKGS  - Python packages to install","cyan")
	@$(call print_colored,"                 Default: python-lsp-server | virtualenvwrapper","plain")

install-nvim: install-brew
ifeq ($(UNAME_S),Darwin)
	@$(call print_colored,"Installing Neovim on macOS...")
	@if command -v nvim >/dev/null 2>&1; then \
		printf "\033[1;32m%s\033[0m\n" "✓ Neovim already installed"; \
		nvim --version | head -1; \
	else \
		brew install neovim; \
		printf "\033[1;32m%s\033[0m\n" "✓ Neovim installed successfully"; \
	fi
	@$(call print_colored,"Setting up configuration symlink...")
	@mkdir -p $(HOME)/.config
	@if [ -L $(NVIM_DIR) ]; then \
		current_target=$$(readlink $(NVIM_DIR)); \
		if [ "$$current_target" = "$(CURDIR)" ]; then \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink already exists: $(NVIM_DIR) -> $(CURDIR)"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink exists but points to: $$current_target"; \
		fi \
	elif [ -e $(NVIM_DIR) ]; then \
		backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Backing up existing config to $$backup_dir..."; \
		mv $(NVIM_DIR) $$backup_dir; \
		ln -s $(CURDIR) $(NVIM_DIR); \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
	else \
		ln -s $(CURDIR) $(NVIM_DIR); \
		printf "\033[1;32m%s\033[0m\n" "✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)"; \
	fi
else
	@$(call print_colored,"⚠ Please install Neovim manually on $(UNAME_S)","red")
	@$(call print_colored,"  Visit: https://github.com/neovim/neovim/wiki/Installing-Neovim","plain")
endif

install-nvim-plugins: install-nvim
	@$(call print_colored,"Installing/syncing Neovim plugins...")
	@nvim --headless "+Lazy! sync" +qa 2>&1 | grep -v -E "(Not an editor command|Error detected while processing)" || true
	@$(call print_colored,"✓ Plugins installed successfully")

update:
	@$(call print_colored,"Updating Neovim plugins...")
	@nvim --headless "+Lazy! update" +qa 2>&1 | grep -v -E "(Not an editor command|Error detected while processing)" || true
	@$(call print_colored,"✓ Plugins updated successfully")

clean:
	@$(call print_colored,"Cleaning plugin cache...")
	@nvim --headless "+Lazy! clean" +qa 2>&1 | grep -v -E "(Not an editor command|Error detected while processing)" || true
	@$(call print_colored,"✓ Cache cleaned successfully")

backup:
	@$(call print_colored,"Backing up configuration to $(BACKUP_DIR)...")
	@cp -r $(NVIM_DIR) $(BACKUP_DIR)
	@$(call print_colored,"✓ Backup created at $(BACKUP_DIR)")

link:
	@$(call print_colored,"Creating symlink to ~/.config/nvim...")
	@if [ -e $(NVIM_DIR) ] || [ -L $(NVIM_DIR) ]; then \
		if [ -L $(NVIM_DIR) ]; then \
			current_target=$$(readlink $(NVIM_DIR)); \
			if [ "$$current_target" = "$(CURDIR)" ]; then \
				printf "\033[1;32m%s\033[0m\n" "✓ Symlink already points to $(CURDIR)"; \
				exit 0; \
			fi; \
		fi; \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(NVIM_DIR) already exists"; \
		backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
		printf "%s\n" "Creating backup at $$backup_dir..."; \
		mv $(NVIM_DIR) $$backup_dir; \
		printf "\033[1;32m%s\033[0m\n" "✓ Backup created at $$backup_dir"; \
	fi
	@mkdir -p $(HOME)/.config
	@ln -s $(CURDIR) $(NVIM_DIR)
	@$(call print_colored,"✓ Symlink created: $(NVIM_DIR) -> $(CURDIR)")

unlink:
	@$(call print_colored,"Removing symlink from ~/.config/nvim...")
	@if [ -L $(NVIM_DIR) ]; then \
		current_target=$$(readlink $(NVIM_DIR)); \
		if [ "$$current_target" = "$(CURDIR)" ]; then \
			rm $(NVIM_DIR); \
			printf "\033[1;32m%s\033[0m\n" "✓ Symlink removed: $(NVIM_DIR)"; \
		else \
			printf "\033[1;33m%s\033[0m\n" "⚠ Symlink points to different location: $$current_target"; \
			printf "%s\n" "  Not removing to prevent data loss"; \
		fi \
	elif [ -e $(NVIM_DIR) ]; then \
		printf "\033[1;33m%s\033[0m\n" "⚠ $(NVIM_DIR) exists but is not a symlink"; \
		printf "%s\n" "  Not removing to prevent data loss"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ No symlink found at $(NVIM_DIR)"; \
	fi

purge-nvim:
	@$(call print_colored,"⚠ WARNING: This will completely remove Neovim and all its data!","red")
	@$(call print_colored,"This includes:","red")
	@$(call print_colored,"  - Neovim installation (via brew)","plain")
	@$(call print_colored,"  - Configuration symlink (~/.config/nvim)","plain")
	@$(call print_colored,"  - Plugin data (~/.local/share/nvim)","plain")
	@$(call print_colored,"  - State/logs (~/.local/state/nvim)","plain")
	@$(call print_colored,"  - Cache (~/.cache/nvim)","plain")
	@echo ""
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		printf "%s\n" "Purging Neovim..."; \
		if command -v brew >/dev/null 2>&1; then \
			printf "%s\n" "Uninstalling Neovim via Homebrew..."; \
			brew uninstall neovim || printf "\033[1;33m%s\033[0m\n" "⚠ Neovim not installed via brew"; \
		fi; \
		if [ -L $(NVIM_DIR) ]; then \
			printf "%s\n" "Removing config symlink..."; \
			rm $(NVIM_DIR); \
		elif [ -d $(NVIM_DIR) ]; then \
			backup_dir=$(HOME)/.config/nvim-backup-$$(date +%Y%m%d-%H%M%S); \
			printf "%s\n" "Backing up config to $$backup_dir..."; \
			mv $(NVIM_DIR) $$backup_dir; \
		fi; \
		printf "%s\n" "Removing data directory..."; \
		rm -rf $(HOME)/.local/share/nvim; \
		printf "%s\n" "Removing state directory..."; \
		rm -rf $(HOME)/.local/state/nvim; \
		printf "%s\n" "Removing cache directory..."; \
		rm -rf $(HOME)/.cache/nvim; \
		printf "\033[1;32m%s\033[0m\n" "✓ Neovim completely purged"; \
	else \
		printf "%s\n" "Purge cancelled"; \
	fi

install-brew:
ifeq ($(UNAME_S),Darwin)
	@if ! command -v brew >/dev/null 2>&1; then \
		printf "%s\n" "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		printf "\033[1;32m%s\033[0m\n" "✓ Homebrew installed successfully"; \
	else \
		printf "\033[1;32m%s\033[0m\n" "✓ Homebrew already installed"; \
	fi
else
	@$(call print_colored,"⚠ Homebrew installation is only supported on macOS","red")
endif

install-python: install-brew
	@$(call print_colored,"Installing Python development tools...")
	@for pkg in $(PYTHON_PKGS); do \
		printf "%s\n" "Installing $$pkg..."; \
		brew install $$pkg || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to install $$pkg"; \
	done
	@$(call print_colored,"✓ Python packages installation complete")

install-dev-tools: install-brew
	@$(call print_colored,"Installing development tools...")
	@for tool in $(DEV_TOOLS); do \
		printf "%s\n" "Installing $$tool..."; \
		brew install $$tool || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to install $$tool"; \
	done
	@$(call print_colored,"✓ Development tools installation complete")

install-fonts: install-brew
ifeq ($(UNAME_S),Darwin)
	@$(call print_colored,"Installing Nerd Fonts on macOS...")
	@for font in $(NERD_FONTS); do \
		printf "%s\n" "Installing $$font..."; \
		brew install --cask $$font || printf "\033[1;33m%s\033[0m\n" "⚠ Failed to install $$font"; \
	done
	@$(call print_colored,"✓ Nerd Fonts installation complete")
else ifeq ($(UNAME_S),Linux)
	@$(call print_colored,"Installing Nerd Fonts on Linux...")
	@mkdir -p $(HOME)/.local/share/fonts
	@for font in $(NERD_FONTS); do \
		font_name=$$(echo $$font | sed 's/font-//;s/-nerd-font//;s/-/ /g'); \
		printf "%s\n" "Downloading $$font_name..."; \
		curl -fLo "$(HOME)/.local/share/fonts/$$font.zip" \
			"https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$$font_name.zip" || \
			printf "\033[1;33m%s\033[0m\n" "⚠ Failed to download $$font"; \
		unzip -o "$(HOME)/.local/share/fonts/$$font.zip" -d "$(HOME)/.local/share/fonts/" 2>/dev/null || true; \
		rm -f "$(HOME)/.local/share/fonts/$$font.zip"; \
	done
	@fc-cache -fv
	@$(call print_colored,"✓ Nerd Fonts installation complete")
else
	@$(call print_colored,"⚠ Unsupported OS: $(UNAME_S)","red")
endif

test-nerd-fonts: test-smoke

test-smoke:
	@$(call print_colored,"Running Nerd Fonts Smoke Test...","cyan")
	@bash .tests/smoke-test.sh

test-unicode:
	@$(call print_colored,"Running Unicode Range Test...","cyan")
	@bash .tests/unicode-range-test.sh

test-icons:
	@$(call print_colored,"Running Comprehensive Icon Sets Test...","cyan")
	@bash .tests/icon-sets-test.sh

test-all:
	@$(call print_colored,"Running All Nerd Fonts Tests...","cyan")
	@echo ""
	@$(call print_colored,"[1/3] Smoke Test","yellow")
	@bash .tests/smoke-test.sh
	@echo ""
	@$(call print_colored,"[2/3] Unicode Range Test","yellow")
	@bash .tests/unicode-range-test.sh
	@echo ""
	@$(call print_colored,"[3/3] Comprehensive Icon Sets Test","yellow")
	@bash .tests/icon-sets-test.sh
	@echo ""
	@$(call print_colored,"All tests completed!","green")

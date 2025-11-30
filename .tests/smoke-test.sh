#!/bin/bash

# Color printing function
print_colored() {
    local msg="$1"
    local color="${2:-green}"

    case "$color" in
        red)    printf '\033[1;31m%s\033[0m\n' "$msg" ;;
        green)  printf '\033[1;32m%s\033[0m\n' "$msg" ;;
        yellow) printf '\033[1;33m%s\033[0m\n' "$msg" ;;
        cyan)   printf '\033[1;36m%s\033[0m\n' "$msg" ;;
        blue)   printf '\033[1;34m%s\033[0m\n' "$msg" ;;
        plain)  printf '%s\n' "$msg" ;;
        *)      printf '\033[1;32m%s\033[0m\n' "$msg" ;;
    esac
}

echo "Normal"
echo "\033[1mBold\033[22m"
echo "\033[3mItalic\033[23m"
echo "\033[3;1mBold Italic\033[0m"
echo "\033[4mUnderline\033[24m"
echo "== === !== >= <= =>"
echo "契          勒 鈴 "

echo ""
print_colored "Testing Nerd Font Icons & Formatting" "cyan"
print_colored "====================================" "cyan"
echo ""

print_colored "Text Formatting:" "yellow"
printf "  Normal text\n"
printf "  \033[1mBold text\033[0m\n"
printf "  \033[3mItalic text\033[0m\n"
printf "  \033[4mUnderline text\033[0m\n"
printf "  == === !== >= <= =>\n"
echo ""

print_colored "Powerline Symbols:" "yellow"
printf "  Branch:      \n"
printf "  Line:        \n"
printf "  Lock:        \n"
printf "  Separators:        \n"
echo ""

print_colored "Common Nerd Font Icons:" "yellow"
printf "  Home:         \n"
printf "  Search:       \n"
printf "  Settings:     \n"
printf "  Download:     \n"
printf "  Upload:       \n"
printf "  Check:        \n"
printf "  Warning:      \n"
printf "  Error:        \n"
echo ""

print_colored "File Type Icons:" "yellow"
printf "  Python (.py):       \n"
printf "  JavaScript (.js):   \n"
printf "  TypeScript (.ts):   \n"
printf "  Go (.go):           \n"
printf "  Rust (.rs):         \n"
printf "  C (.c):             \n"
printf "  C++ (.cpp):         \n"
printf "  Java (.java):       \n"
printf "  Ruby (.rb):         \n"
printf "  PHP (.php):         \n"
printf "  HTML (.html):       \n"
printf "  CSS (.css):         \n"
echo ""

print_colored "Configuration Files:" "yellow"
printf "  JSON (.json):       \n"
printf "  YAML (.yaml):       \n"
printf "  TOML (.toml):       \n"
printf "  Vim (.vim):         \n"
printf "  Shell (.sh):        \n"
printf "  Zsh (.zsh):         \n"
echo ""

print_colored "Special Files:" "yellow"
printf "  Git (.gitignore):   \n"
printf "  Docker:            󰡨 \n"
printf "  Markdown (.md):     \n"
printf "  Makefile:           \n"
printf "  Terraform (.tf):    \n"
printf "  Log (.log):         \n"
printf "  Database:           \n"
printf "  Terminal:           \n"
echo ""

print_colored "Folder Icons:" "yellow"
printf "  Open Folder:        \n"
printf "  Closed Folder:      \n"
printf "  Git Folder:         \n"
echo ""

print_colored "If you see squares or missing characters:" "yellow"
printf "  1. Install a Nerd Font: make install-fonts\n"
printf "  2. Set your terminal to use a Nerd Font (e.g., Hack Nerd Font)\n"
printf "  3. Restart your terminal\n"

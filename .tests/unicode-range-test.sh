#!/bin/bash

# Unicode Range Test for Nerd Fonts
# Based on nerd-fonts test-fonts.sh
# Displays icon ranges in table format with hex codes

# Color codes
RESET='\033[0m'
BOLD='\033[1m'
BG_GRAY='\033[48;5;240m'
BG_DARK='\033[48;5;235m'
FG_CYAN='\033[1;36m'
FG_YELLOW='\033[1;33m'
FG_WHITE='\033[1;37m'

# Print header
print_header() {
    local title="$1"
    echo ""
    printf "${FG_CYAN}${BOLD}%s${RESET}\n" "$title"
    printf "${FG_CYAN}%s${RESET}\n" "$(printf '=%.0s' {1..60})"
}

# Print Unicode range in table format
# Args: start_hex end_hex columns range_name
print_unicode_range() {
    local start_hex="$1"
    local end_hex="$2"
    local cols="${3:-16}"
    local range_name="$4"

    local start_dec=$((16#${start_hex}))
    local end_dec=$((16#${end_hex}))

    print_header "$range_name (U+$start_hex - U+$end_hex)"

    # Print column headers
    printf "     "
    for ((i=0; i<cols; i++)); do
        printf " %2X" "$i"
    done
    printf "\n"

    printf "     "
    for ((i=0; i<cols; i++)); do
        printf "───"
    done
    printf "\n"

    local count=0
    local row_start=$start_dec

    for ((code=start_dec; code<=end_dec; code++)); do
        # Print row header at start of each row
        if [ $((count % cols)) -eq 0 ]; then
            printf "${FG_YELLOW}%04X${RESET} " "$code"
            row_start=$code
        fi

        # Alternate background colors for better visibility
        if [ $(((code - row_start) / cols % 2)) -eq 0 ]; then
            bg="$BG_GRAY"
        else
            bg="$BG_DARK"
        fi

        # Print the character with background
        printf "${bg} $(printf '\\U%08x' $code) ${RESET}"

        count=$((count + 1))

        # New line at end of row
        if [ $((count % cols)) -eq 0 ]; then
            printf "\n"
        fi
    done

    # Fill remaining cells in last row if needed
    if [ $((count % cols)) -ne 0 ]; then
        for ((i=count % cols; i<cols; i++)); do
            printf "   "
        done
        printf "\n"
    fi
}

# Print range with hex codes visible
print_unicode_with_codes() {
    local start_hex="$1"
    local end_hex="$2"
    local range_name="$3"

    local start_dec=$((16#${start_hex}))
    local end_dec=$((16#${end_hex}))

    print_header "$range_name (U+$start_hex - U+$end_hex)"

    for ((code=start_dec; code<=end_dec; code++)); do
        printf "  U+%04X: $(printf '\\U%08x' $code)  " "$code"

        # 4 icons per line
        if [ $(((code - start_dec + 1) % 4)) -eq 0 ]; then
            printf "\n"
        fi
    done
    printf "\n"
}

# Main test function
test_nerd_fonts() {
    echo ""
    printf "${BOLD}${FG_CYAN}╔════════════════════════════════════════════════════════╗${RESET}\n"
    printf "${BOLD}${FG_CYAN}║     Nerd Fonts Unicode Range Test                     ║${RESET}\n"
    printf "${BOLD}${FG_CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"

    # Seti-UI + Custom
    print_unicode_range "e5fa" "e6b5" 12 "Seti-UI + Custom"

    # Devicons
    print_unicode_range "e700" "e7c5" 12 "Devicons"

    # Font Awesome
    print_unicode_range "f000" "f2e0" 16 "Font Awesome"

    # Font Awesome Extension
    print_unicode_range "e200" "e2a9" 12 "Font Awesome Extension"

    # Material Design Icons
    print_unicode_range "f0001" "f1af0" 16 "Material Design Icons (Sample)"

    # Weather Icons
    print_unicode_range "e300" "e3e3" 12 "Weather"

    # Octicons
    print_unicode_range "f400" "f532" 12 "Octicons"

    # Powerline Symbols
    print_unicode_range "e0a0" "e0a2" 8 "Powerline Symbols"
    print_unicode_range "e0b0" "e0b3" 8 "Powerline Extra Symbols"

    # Powerline Extra
    print_unicode_range "e0a3" "e0a3" 4 "Powerline Triangle"
    print_unicode_range "e0b4" "e0c8" 8 "Powerline Extra"
    print_unicode_range "e0ca" "e0ca" 4 "Powerline Flame"
    print_unicode_range "e0cc" "e0d4" 8 "Powerline Misc"

    # Pomicons
    print_unicode_range "e000" "e00a" 8 "Pomicons"

    # Codicons
    print_unicode_range "ea60" "ec1e" 12 "Codicons (VS Code Icons)"

    # Font Logos (Font Linux)
    print_unicode_with_codes "f300" "f32f" "Font Logos / Linux"

    # IEC Power Symbols
    print_unicode_with_codes "23fb" "23fe" "IEC Power Symbols"
    print_unicode_with_codes "2b58" "2b58" "IEC Power Symbol Shield"

    echo ""
    print_header "Testing Complete"
    printf "${FG_YELLOW}If you see boxes/squares, install a Nerd Font and set it in your terminal${RESET}\n"
    echo ""
}

# Run the test
test_nerd_fonts

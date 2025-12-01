#!/usr/bin/env bash
# Gruvbox Dark theme for tmux-powerline
# Matches colors from .tmux.conf gruvbox configuration
# Location: ~/.config/tmux-powerline/themes/gruvbox-dark.sh

# Gruvbox Dark 256-color palette
readonly GRUVBOX_BG0="235"      # #282828 - darkest background
readonly GRUVBOX_BG1="237"      # #3c3836 - main background
readonly GRUVBOX_BG2="239"      # #504945
readonly GRUVBOX_BG3="241"      # #665c54
readonly GRUVBOX_BG4="243"      # #7c6f64

readonly GRUVBOX_FG0="229"      # #fbf1c7 - lightest foreground
readonly GRUVBOX_FG1="223"      # #ebdbb2 - main foreground
readonly GRUVBOX_FG2="250"      # #d5c4a1
readonly GRUVBOX_FG3="248"      # #bdae93
readonly GRUVBOX_FG4="246"      # #a89984

readonly GRUVBOX_RED="167"      # #fb4934
readonly GRUVBOX_GREEN="142"    # #b8bb26
readonly GRUVBOX_YELLOW="214"   # #fabd2f
readonly GRUVBOX_BLUE="109"     # #83a598
readonly GRUVBOX_PURPLE="175"   # #d3869b
readonly GRUVBOX_AQUA="108"     # #8ec07c
readonly GRUVBOX_ORANGE="208"   # #fe8019

# Default colors
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR="${GRUVBOX_BG1}"
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR="${GRUVBOX_FG1}"

# Separator configuration
# Check if patched font is in use (set in config.sh)
TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""

# Default separators for left and right sides
TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR="${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}"
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR="${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}"

# ============================================================================
# LEFT STATUS SEGMENTS
# ============================================================================
# Format: "segment_name bg_color fg_color [separator] [separator_fg] [spacing]"
# Segments are displayed left to right in the order listed

if [ -z "${TMUX_POWERLINE_LEFT_STATUS_SEGMENTS}" ]; then
    TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
        # Session info - prominent yellow accent
        "tmux_session_info ${GRUVBOX_YELLOW} ${GRUVBOX_BG0}" \

        # Hostname - blue for system identity
        "hostname ${GRUVBOX_BG3} ${GRUVBOX_FG1}" \

        # Network segments - aqua/blue tones for connectivity
        "lan_ip ${GRUVBOX_BLUE} ${GRUVBOX_BG0}" \
        "wan_ip ${GRUVBOX_AQUA} ${GRUVBOX_BG0} ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}" \
        "ifstat ${GRUVBOX_BG3} ${GRUVBOX_AQUA} ${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}" \
    )
fi

# ============================================================================
# RIGHT STATUS SEGMENTS
# ============================================================================
# Segments are displayed right to left in the order listed
# Priority order: System monitoring → Time/Location → Date

if [ -z "${TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS}" ]; then
    TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
        # System monitoring - warm colors for load/performance
        "load ${GRUVBOX_BG2} ${GRUVBOX_RED}" \
        "cpu ${GRUVBOX_BG2} ${GRUVBOX_ORANGE}" \
        "mem_used ${GRUVBOX_BG2} ${GRUVBOX_YELLOW}" \

        # Weather - purple for external data
        "weather ${GRUVBOX_BG3} ${GRUVBOX_PURPLE}" \

        # Time display - blue tones for temporal info
        "time ${GRUVBOX_BG3} ${GRUVBOX_BLUE}" \
        "date ${GRUVBOX_BG3} ${GRUVBOX_FG1}" \
    )
fi

# ============================================================================
# WINDOW STATUS (center)
# ============================================================================
# Format for current window
if [ -z "${TMUX_POWERLINE_WINDOW_STATUS_CURRENT}" ]; then
    TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
        "#[fg=${GRUVBOX_BG1},bg=${GRUVBOX_YELLOW}]${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}" \
        "#[fg=${GRUVBOX_BG0},bg=${GRUVBOX_YELLOW},bold] #I  #W " \
        "#[fg=${GRUVBOX_YELLOW},bg=${GRUVBOX_BG1},nobold]${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}"
    )
fi

# Format for other windows
if [ -z "${TMUX_POWERLINE_WINDOW_STATUS_FORMAT}" ]; then
    TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
        "#[fg=${GRUVBOX_BG1},bg=${GRUVBOX_BG2}]${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}" \
        "#[fg=${GRUVBOX_FG1},bg=${GRUVBOX_BG2}] #I  #W " \
        "#[fg=${GRUVBOX_BG2},bg=${GRUVBOX_BG1}]${TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}"
    )
fi

#!/usr/bin/env bash
# tmux-powerline configuration for gruvbox dark theme
# Location: ~/.config/tmux-powerline/config.sh
# Managed by dotfile repo at /Users/amninder/projects/configs/dotfile

# General settings
export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

# Custom theme and segment directories
export TMUX_POWERLINE_DIR_USER_THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/themes"
export TMUX_POWERLINE_DIR_USER_SEGMENTS="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/segments"

# Theme selection
export TMUX_POWERLINE_THEME="gruvbox-dark"

# Separator configuration
# Powerline glyphs (requires Nerd Font):
# export TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
# export TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
# export TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
# export TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""

# ASCII fallback (works without special fonts):
export TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
export TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
export TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
export TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"

# Segment: date
export TMUX_POWERLINE_SEG_DATE_FORMAT="%F"

# Segment: time
export TMUX_POWERLINE_SEG_TIME_FORMAT="%H:%M"

# Segment: hostname
export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="short"

# Segment: weather
# Set your location for weather - update this!
# Visit https://www.yr.no/ and search for your location, then copy the location ID from the URL
export TMUX_POWERLINE_SEG_WEATHER_LOCATION=""  # e.g., "2459115" for New York
export TMUX_POWERLINE_SEG_WEATHER_DATA_PROVIDER="yrno"  # or "openweathermap"
export TMUX_POWERLINE_SEG_WEATHER_UNIT="c"  # celsius

# Segment: load average
export TMUX_POWERLINE_SEG_LOAD_AVG_THRESHOLD="2.0"

# Segment: CPU
export TMUX_POWERLINE_SEG_CPU_THRESHOLD="75"

# Segment: RAM
export TMUX_POWERLINE_SEG_RAM_THRESHOLD="75"

# Segment: LAN IP
export TMUX_POWERLINE_SEG_LAN_IP_DISPLAY_INTERFACE="auto"

# Segment: WAN IP
export TMUX_POWERLINE_SEG_WAN_IP_UPDATE_PERIOD="3600"  # Update every hour

# Segment: bandwidth (ifstat)
export TMUX_POWERLINE_SEG_IFSTAT_INTERFACE="auto"
export TMUX_POWERLINE_SEG_IFSTAT_UNIT="B"  # Bytes

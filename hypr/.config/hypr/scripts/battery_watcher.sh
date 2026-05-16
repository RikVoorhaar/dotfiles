#!/usr/bin/env bash

BAT_THRESHOLD1=20
BAT_THRESHOLD2=10
BAT_THRESHOLD3=5

# Your normal Hyprland border (gradient)
COLOR_NORMAL='rgba(42f560ee) rgba(42b6f5ee) 45deg'

# Warning colors (solid)
COLOR_LOW="rgba(ffcc33ee)"      # <20%
COLOR_CRIT="rgba(ff6633ee)"     # <10%
COLOR_DANGER="rgba(ff0000ee)"   # <5%

LAST_LEVEL_FILE="/tmp/battery_last_level"

get_battery() {
    if command -v acpi >/dev/null 2>&1; then
        acpi -b | grep -oP '(?<=, )\d+(?=%)'
    else
        dev=$(upower -e | grep BAT | head -n1)
        upower -i "$dev" | awk '/percentage:/ {gsub(/%/,"",$2); print $2}'
    fi
}

set_border_color() {
    local level=$1
    if (( level <= BAT_THRESHOLD3 )); then
        hyprctl keyword general:col.active_border "$COLOR_DANGER" >/dev/null 2>&1
    elif (( level <= BAT_THRESHOLD2 )); then
        hyprctl keyword general:col.active_border "$COLOR_CRIT" >/dev/null 2>&1
    elif (( level <= BAT_THRESHOLD1 )); then
        hyprctl keyword general:col.active_border "$COLOR_LOW" >/dev/null 2>&1
    else
        hyprctl keyword general:col.active_border "$COLOR_NORMAL" >/dev/null 2>&1
    fi
}

send_notice() {
    local urgency=$1
    local title=$2
    local body=$3
    notify-send -u "$urgency" "$title" "$body"
}

while true; do
    level=$(get_battery)
    [[ -z "$level" ]] && sleep 60 && continue

    last_level=100
    [[ -f "$LAST_LEVEL_FILE" ]] && last_level=$(cat "$LAST_LEVEL_FILE")

    if (( level <= BAT_THRESHOLD3 && last_level > BAT_THRESHOLD3 )); then
        send_notice critical "Battery CRITICAL" "Battery at ${level}%, suspending soon!"
        # Optional: auto-suspend
        # systemctl suspend
    elif (( level <= BAT_THRESHOLD2 && last_level > BAT_THRESHOLD2 )); then
        send_notice critical "Battery very low" "Battery at ${level}%"
    elif (( level <= BAT_THRESHOLD1 && last_level > BAT_THRESHOLD1 )); then
        send_notice normal "Battery low" "Battery at ${level}%"
    fi

    echo "$level" > "$LAST_LEVEL_FILE"
    set_border_color "$level"

    sleep 30
done


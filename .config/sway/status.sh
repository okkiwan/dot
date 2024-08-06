battery=$(cat /sys/class/power_supply/BAT0/capacity)
date=$(date +'%Y-%m-%d %I:%M %p')

echo "$battery% | $date"

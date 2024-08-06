# battery capacity
battery_charge=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# date
date=$(date +'%Y-%m-%d %I:%M %p')

# volume
if pamixer --get-mute | grep -q "true"; then
        volume=M
else
        volume=$(pamixer --get-volume)db
fi

#output
echo "$volume | $battery_charge% ($battery_status) | $date"

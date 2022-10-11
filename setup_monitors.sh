## Pentru setup monitoare atelier
# Asezarea corespunzatoare monitoarelor fizice
xrandr --output DP-3 --right-of DP-7 --auto

# Monitorul mare yellow tint
xrandr --output DP-3 --gamma 1.0:0.9:0.9

# Monitorul mic yellow tint
xrandr --output DP-7 --gamma 1.0:0.9:0.8

## Setup monitoare laptop
xrandr --output DVI-I-2-1 --auto --right-of eDP-1-1

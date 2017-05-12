#!/bin/sh
intel_reg write 0x00061254 "$(cat /home/twk/tmp/backlight)" 2> /dev/null
DISPLAY=:1.0 /home/twk/dotfiles/sct/sctd.sh oneshot

#!/bin/sh

random() {
    awk 'BEGIN {srand(); OFMT="%.17f"} {print rand(), $0}' - |
    sort -k1,1n | cut -d ' ' -f2- | head -n 1;
}

tick() {
    img=$(find ~/dotfiles/wallpapers/ -regex ".*\(jpg\|png\)" | grep -v "old" | random)
    bgs -z "$img" > /dev/null 2>&1
}

tick
[ "$1" = "oneshot" ] && exit 0

while true; do
    tick
    sleep 1800
done

#!/bin/sh
val=$(doas intel_reg read 0x00061254 2> /dev/null | sed "s/.*: 0x//")
echo "$val"

if [ "$(echo "$val" | cut -c 1-4)" = "0610" ]; then
    field="$(echo "$val" | cut -c 5-8)"
    echo "$field"
    new="6000"
    case $field in
        "040f")
            new="6000"
            ;;
        "0308")
            new="4051"
            ;;
        "026c")
            new="3000"
            ;;
        "0200")
            new="2666"
            ;;
        "01c2")
            new="1fae"
            ;;
        "0174")
            new="1bd7"
            ;;
        "0136")
            new="170a"
            ;;
        "0117")
            new="1333"
            ;;
        "00c9")
            new="1147"
            ;;
        "00aa")
            new="0c7a"
            ;;
        "008b")
            new="0a8f"
            ;;
        "006c")
            new="08a3"
            ;;
        "004d")
            new="06b8"
            ;;
        "003e")
            new="04cc"
            ;;
        "001f")
            new="03d7"
            ;;
    esac

    doas -n intel_reg write 0x00061254 "0x6000$new"
fi

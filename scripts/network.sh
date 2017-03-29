#!/bin/sh
out=$(nmcli -m tabular -t -f "IP4.ADDRESS" dev show enp0s25)
if [ "$out" != "" ]; then
    echo "enp0s25: %{F#268bd2}[$out]"
else
    out=$(nmcli -m tabular -t -f "GENERAL.CONNECTION,IP4.ADDRESS" dev show wlp2s0 |
    sed -z "s/\\n/: %{F#268bd2}[/")
    if echo "$out" | grep -e "--" > /dev/null; then
        echo "no net"
    else
        echo "$out]"
    fi
fi

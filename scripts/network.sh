#!/bin/sh
if ip route show to 0/0 | grep "personal" > /dev/null; then
    vpn="(vpn)"
fi

out=$(nmcli -m tabular -t -f "IP4.ADDRESS" dev show enp0s25)
if [ "$out" != "" ]; then
    echo "enp0s25$vpn: %{F#6684e1}[$out]"
else
    out=$(nmcli -m tabular -t -f "GENERAL.CONNECTION,IP4.ADDRESS" dev show wlp2s0 |
    sed -z "s/\\n/$vpn: %{F#6684e1}[/")
    if echo "$out" | grep -e "--" > /dev/null; then
        echo "no net"
    else
        echo "$out]"
    fi
fi

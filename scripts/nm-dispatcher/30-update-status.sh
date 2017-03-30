#!/bin/sh
sleep .2
exec "$DOTFILES"/scripts/network.sh > "$MYHOME"/tmp/net_fifo

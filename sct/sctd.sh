#!/bin/sh

# Copyright (c) 2017 Aaron Bieber <aaron@bolddaemon.com>
# Copyright (c) 2017 Inokentiy Babushkin <twk@twki.de>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

TEMP_MIN=1500
TEMP_MAX=6500

INC=$(((TEMP_MAX - TEMP_MIN) / 720))
SCT=$(which sct)

if [ ! -e "$SCT" ]; then
    echo "Please install sct!"
    exit 1;
fi

setHM() {
    H=$(date +"%H" | sed -e 's/^0//')
    M=$(date +"%M" | sed -e 's/^0//')
    HM=$((H*60 + M))
}

setTEMP() {
    if [ $HM -gt 720 ]; then
        TEMP=$(( TEMP_MIN + INC * (1440 - HM) ))
    else
        TEMP=$(( TEMP_MIN + INC * HM ))
    fi
}

tick() {
    setHM
    setTEMP

    $SCT $TEMP
}

tick
[ "$1" = "oneshot" ] && exit 0

while true; do
    tick
    sleep 600
done

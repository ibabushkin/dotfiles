#!/bin/sh
fzy=false
if [ "$1" = "fzy" ]; then
    fzy=true
    shift
fi

case "$1" in
    uzbl) program="uzbl-browser" ;;
    *) program=$1 ;;
esac
shift

if $fzy; then
    cat "$@" | fzy | sed -r "s/^# .*$//
    s/^ *\* (.* :: )*//"
else
    sed -r "s/^# .*$//
    s/^ *\* (.* :: )*//" "$@"
fi |
while read -r line; do
    case "$line" in
        http*) $program "$line" > /dev/null 2>&1 & ;;
    esac
done

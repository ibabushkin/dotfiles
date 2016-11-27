#!/bin/sh
case "$1" in
	firefox) program="firefox --new-tab" ;;
	uzbl) program="uzbl-browser" ;;
	*) program=$1 ;;
esac
shift

sed -r "s/^# .*$//
	s/^ *\* (.* :: )*//" $@ | while read line; do
	case "$line" in
		http*) $program $line 2>&1 > /dev/null & ;;
	esac
done

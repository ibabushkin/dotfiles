#!/bin/sh
fzy=false
if [[ "$1" == "fzy" ]]; then
	fzy=true
	shift
fi

case "$1" in
	uzbl) program="uzbl-browser" ;;
	*) program=$1 ;;
esac
shift

sed -r "s/^# .*$//
	s/^ *\* (.* :: )*//" $@ | if [[ $fzy == true ]]; then
	fzy | xargs $program &
else
	while read line; do
		case "$line" in
			http*) $program $line 2>&1 > /dev/null & ;;
		esac
	done
fi

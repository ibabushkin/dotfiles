#!/bin/sh

# output info to the appropriate place
output() {
    echo "$_status$*" > ~/tmp/cmus_fifo
}

# read in the variables (given as ./cmus.sh var1_name var1_value var2_name var2_value ...)
while [ $# -ge 2 ]; do
	eval _$1='$2'
	shift
	shift
done

# render status (early exit if no playback is running)
case "$_status" in
    "stopped")
        output ""
        exit 0
        ;;
    "playing")
        _status="[|>]"
        ;;
    "paused")
        _status="[||]"
        ;;
    *)
        exit 1
        ;;
esac

# build output string
if [ -n "$_file" ] || [ -n "$_url" ]; then
    str=":"
    [ -n "$_artist" ] && str="$str $_artist"
    [ -n "$_artist" ] && [ -n "$_title" ] && str="$str -"
    [ -n "$_title" ] && str="$str $_title"
	output $str
else
	output
fi

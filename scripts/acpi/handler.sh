#!/bin/sh
# Default acpi script that takes an entry for all actions

minspeed=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`
maxspeed=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
setspeed="/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"

set $*

PID=$(pgrep dbus-launch)
export USER=$(ps -o user --no-headers $PID)
USERHOME=$(getent passwd $USER | cut -d: -f6)
export XAUTHORITY="$USERHOME/.Xauthority"
for x in /tmp/.X11-unix/*; do
    displaynum=`echo $x | sed s#/tmp/.X11-unix/X##`
    if [ x"$XAUTHORITY" != x"" ]; then
        export DISPLAY=":$displaynum"
    fi
done

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger "PowerButton pressed: $2, shutting down..."
                shutdown -P now
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SBTN|SLPB)
                logger "Sleep Button pressed: $2, suspending..."
                DISPLAY=:0 doas -u twk slock
                sleep .2
                zzz
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        echo -n $minspeed >$setspeed
                        ;;
                    00000001)
                        echo -n $maxspeed >$setspeed
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        ;;
                    00000001)
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger "LID closed, suspending..."
                DISPLAY=:0 doas -u twk slock &
                sleep .2
                zzz
                ;;
            open)
                logger "LID opened"
                ;;
            *)
                logger "ACPI action undefined (LID): $2"
                ;;
        esac
        ;;
    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

printf "load: %s %s %s" $(cat /proc/loadavg | cut -d " " -f 1-3)

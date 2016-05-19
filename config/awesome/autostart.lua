local awful = require("awful")

function logs ()
    awful.util.spawn_with_shell("termite --class Log -e /home/thewormkill/.log2")
    awful.util.spawn_with_shell("termite --class Log -e /home/thewormkill/.log1")
end

function monitors ()
    awful.util.spawn("termite --class Monitor -e \"htop\"")
end

logs()
monitors()

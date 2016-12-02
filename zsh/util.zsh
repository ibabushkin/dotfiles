reload () {
    exec "${SHELL}" "$@"
}

# useful when you need to translate weird-as-fuck path into a single-argument
escape() {
    local escape_string_input
    echo -n "String to escape: "
    read escape_string_input
    printf '%q\n' "$escape_string_input"
}

# spawn a notification with a message after some delay
function alarm () {
    sleep ${(ps: :)1} # split the first argument on each space (ie. 1m 2s)
    shift
    notify-send -u critical -a "alarm" "$*"
}

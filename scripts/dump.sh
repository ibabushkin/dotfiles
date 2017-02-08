#!/bin/bash
remove=false

if [[ $1 == "--help" ]]; then
    exit 0
elif [[ $1 == "-s" ]]; then
    dir="img"
    files="$2"
    shift; shift
    remove=true

    scrot $@ $files
else
    dir=$1
    shift
    files=$@
fi

if $(scp -r $files "toaster:/var/www/htdocs/$dir"); then
    echo ""

    for file in $files; do
        echo "https://twki.de/$dir/$(basename $file)"
    done

    if $remove; then
        rm -r $files
    fi
fi

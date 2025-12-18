
#!/bin/sh

function unlinkify() {
    link=$(readlink "$1")
    rm "$1"
    cp "$link" "$1"
}

FILES=(".config/gtk-3.0/gtk.css" ".config/gtk-3.0/gtk-dark.css" ".config/gtk-4.0/gtk.css" ".config/gtk-4.0/gtk-dark.css")

for file in "${FILES[@]}"; do
    fname="$HOME/${file}"
    if [ -L "$fname" ]; then
        unlinkify "$fname"
    fi
    if [ ! -e "$fname" ]; then
        pushd $(dirname "$fname")
            ln -s colors.css "$fname"
        popd
    else
        # Add @import 'colors.css';
        grep colors.css "${fname}" || sed -i '1i @import "colors.css";' "${fname}"
    fi
done


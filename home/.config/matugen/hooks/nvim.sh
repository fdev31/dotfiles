#!/bin/bash
ls $XDG_RUNTIME_DIR/nvim.* >/dev/null 2>&1 || exit 0
cat >/tmp/vimcolors.sh <<EOF
function runstuff() {
    for addr in "$XDG_RUNTIME_DIR"/nvim.*; do
        [ -S "\$addr" ] || continue

        basename=\${addr##*/}
        pid_part=\${basename#nvim.}
        pid=\${pid_part%%.*}
        case \$pid in
            ''|*[!0-9]*) pid= ;;
        esac

        needs_stop=
        if [ -n "\$pid" ]; then
            state=\$(ps -o stat= -p "\$pid" 2>/dev/null | tr -d '[:space:]')
            if [ "\${state#T}" != "\$state" ]; then
                kill -CONT "\$pid" >/dev/null 2>&1
                needs_stop=1
            fi
        fi

        nvim --server "\$addr" --remote-send "<Esc>:lua dofile('$HOME/.config/nvim/lua/config/colors.lua')<CR>"

        if [ -n "\$needs_stop" ] && [ -n "\$pid" ]; then
            kill -TSTP "\$pid" >/dev/null 2>&1
        fi
    done
}
runstuff
EOF
timeout -s KILL 3s sh /tmp/vimcolors.sh

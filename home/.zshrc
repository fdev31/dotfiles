# vim: foldmethod=marker
# if interactive, show reminders



[ -e ~/liberty/openCode.sh ] && [ ! -d ~/code/onemw-js ] && ~/liberty/openCode.sh

hostname=$(cat /etc/hostname)

if [ "$SHLVL" = "3" ] || [ -n "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
    # scp or non-interactive, don't echo anything
else
    if [ $(tty) = "/dev/tty1" ]; then
        if [ "$hostname"  = "gamix" ]; then
            export WLR_NO_HARDWARE_CURSORS=1
            openrgb -l blue.orp
        fi
        exec Hyprland
    fi
    case $hostname in
        mobidev)
            fastfetch --logo-width 25 --logo ~/Images/nodejs.png
            ;;
        gamix)
            fastfetch --logo-width 25 --logo ~/Images/archlinuxlogo.square.png
            ;;
        *)
            fastfetch --logo arch2
            ;;
    esac
    # Interactive session
    remind -t10 ~/calendar | grep -v "No reminders."
    br
    timeout 2s garbageDay 2> /dev/null
    # }}}
    fpath=($fpath $HOME/.zsh/fn)
    # Prompt & Color stuff{{{
    RPS1=%D{%Hh%M}
    export PS1="%n@%m:%~%# "
    # Attribute codes:
    # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
    # Text color codes:
    # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
    # Background color codes:
    # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
    # Spécifie les couleurs
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.zstd=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.xz=01;31:*.bz2=01;31:*.rpm=01;31:*.deb=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.pdf=01;35:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mkv=01;37:*.mp4=01;37:*.mpg=01;37:*.avi=01;37:*.mov=01;37:*.tbz=01;31:*.zip=01;31:*.blend=01;33:*.mp3=00;34:*.ico=01;35:*.png=01;35:*.89t=00;33';
    if [ "x$TERM" = 'xvt220' ]; then
        export TERM="pcvt25"
    fi

    if [[ "$TERM" = xterm* ]] ; then
        preexec () { print -Pn "\e]0;$1 (%~)\a" }
    fi
    # }}}
    # Completion things{{{
    # :completion:<function-name>:<completer>:<command>:<argument>:<tag>
    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*' completer _expand _complete
    zstyle ':completion:*' format '-- Completing %d --'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' list-colors $LS_COLORS
    # depends des gouts
    zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
    zstyle ':completion:*' matcher-list '' 'l:|=* r:|=*' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*' max-errors 3
    zstyle ':completion:*' menu select=1
    zstyle ':completion:*' prompt '[%e]'
    zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
    zstyle ':completion:*' verbose true
    # Some functions are very slow, this will use a cache to speed up things
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
    zstyle ':completion:*:processes' command 'ps -au$USER'
    zstyle ':completion:*:*:xmms:*' file-patterns '*.mp3:fichiers-mp3:sons *(/):repertoires:répertoires'
    zstyle ':completion:*:*:blender:*' file-patterns '*.blend:fichiers-blend:3D\ scenes *(/):folders:folders'
    zstyle ':completion:*:*:inkscape:*' file-patterns '*.svg:fichiers-svg:svg *(/):folders:folders'
    # }}}
    # key bindings{{{
    bindkey '^A' beginning-of-line '^E' end-of-line '^D' delete-char '^H' backward-delete-char
    bindkey "^[e" edit-command-line
    bindkey '^R' history-incremental-search-backward
    bindkey '^N' history-incremental-search-forward
    # }}}
    # fuzzy modes ;){{{
    setopt CORRECT
    setopt autocd
    #setopt correct_all
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_REDUCE_BLANKS
    # }}}
    # Completion {{{
    # Allow zsh to complete on hostnames found in common config files.{{{
    if [ -f $HOME/.ssh/known_hosts ]; then
        local _myhosts;
        _myhosts=( ${${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ }:#\!*}
        ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*} );
        zstyle ':completion:*' hosts $_myhosts;
    fi

    #` # just to avoid vim syntax to bug :P}}}
    zstyle :compinstall filename "$HOME/.zshenv"
    autoload -U compinit
    compinit
    autoload -U edit-command-line
    zle -N edit-command-line

    # Gere le FTP
    autoload -U zfinit
    zfinit

    # pip zsh completion start
    function _pip_completion {
        local words cword
        read -Ac words
        read -cn cword
        reply=( $( COMP_WORDS="$words[*]" \
                    COMP_CWORD=$(( cword-1 )) \
            PIP_AUTO_COMPLETE=1 $words[1] ) )
    }
    compctl -K _pip_completion pip

    #}}}
    # aliases{{{
    # alias hgview='hgtk log'
    export EZA_MIN_LUMINANCE=60
    export EZA_ICON_SPACING=2

    alias kitty-detach='kitty @detach-window --self'
    alias ls='eza --color-scale=size -t modified --hyperlink'
    alias d='eza --color-scale=all -t modified --hyperlink'
    alias ll='d --icons=always -l'
    alias lla='ll -a'
    alias c='cd ..'
    alias less='less -R'
    alias kmsg='journalctl -ko short-monotonic --no-hostname -e'
    # kitty
    alias icat='kitty +kitten icat'
    alias kdiff='kitty +kitten diff'
    alias kssh='kitty +kitten ssh'
    alias ncdu='ncdu -x --color dark'
    alias detach='clone-in-kitty --type=os-window'
    # pacman
    alias pac-clean='pacman -Qtdq | sudo pacman -Rns -'
    alias clean_rejects='find . -name "*.orig" -or -name "*.rej" -exec rm {} +'
    alias gd='echo -n "cd " > /tmp/fp_tmp; cat ~/.config/frequent_paths | sort | uniq | fzf --preview-window="up:0" >>/tmp/fp_tmp; source /tmp/fp_tmp'
    alias sd='pwd >> ~/.config/frequent_paths'
    alias poetry-env='eval $(poetry env activate)'

    alias vpn='ensureVPN > /dev/null ; ssh gate.vpn sudo wgs'
    alias reflector_fine='reflector -l 10 -c nl --connection-timeout 1 --download-timeout 1 -f 2'

    # chg
    if which chg >/dev/null 2>&1 ; then
        alias hg='chg'
    fi
    if which nvim  >/dev/null; then
        if [ -z "$DISPLAY" ]; then
            alias vim=nvim
        fi
    fi
    if [ -e /usr/bin/thefuck ]; then
        alias fuck='$(thefuck $(fc -ln -1))'
    fi
    # }}}
    # nvm{{{
    if [ -e /usr/share/nvm/init-nvm.sh ]; then
        source /usr/share/nvm/init-nvm.sh
    fi
    # }}}
    # fuzzy search{{{
    [ -d /usr/share/fzf/ ] && source /usr/share/fzf/completion.zsh
    [ -d /usr/share/fzf/ ] && source /usr/share/fzf/key-bindings.zsh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    # }}}
    # Encoding shortcuts
    source ~/scripts/encode
    # Fancy prompt/themes:{{{

    shell_mode="starpurepowpromptline" # powerlevel or promptline pure starship

    case $shell_mode in
        star*)
            eval "$(starship init zsh)"
            ;;
        pure*)
            autoload -U promptinit; promptinit
            zstyle :prompt:pure:git:stash show yes
            prompt pure
            ;;

        prom*)
            source ~/.promptline.sh
            ;;
        pow*)
            POWERLEVEL9K_MODE='awesome-fontconfig'
            POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
            POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-stash git-remotebranch git-tagname)
            POWERLEVEL9K_VCS_HIDE_TAGS=false

            # layout
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context vcs venv virtualenv dir)
            POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs history time)

            # colors
            #            POWERLEVEL9K_OS_ICON_BACKGROUND="white"
            #            POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
            #            POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
            #            POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
            #            POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="lightgreen"

            # POWERLEVEL10K_HOME_ICON="\uf09b"
            source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
            # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
            ;;
        *)
            echo "No prompt theme configured"
            ;;
    esac
    #     [ -f ~/.theme_history ] && theme.sh $(tail -n1 ~/.theme_history)
    # }}}
    if [ -d "/usr/share/zsh/plugins" ]; then
        P="/usr/share/zsh/plugins"
    else
        P="/usr/share/"
    fi
    source $P/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $P/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
function gd() {
    $(sd -d $@)
}

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias ai="llama-cli --hf-repo lmstudio-community/ERNIE-4.5-21B-A3B-PT-GGUF --jinja"
alias giggle='while true; do ydotool mousemove -x 3 -y 3; sleep 2; ydotool mousemove -x -3 -y -3 ; sleep 2; done'

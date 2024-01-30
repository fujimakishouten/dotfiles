# Language
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_COLLATE=ja_JP.UTF-8

# Path
if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi
if [ -d $HOME/.local/bin ]; then
    export PATH=$PATH:$HOME/.local/bin
fi

# bash
shopt -s expand_aliases

# Key bindings
if type peco > /dev/null 2>&1; then
    if type tac > /dev/null 2>&1; then
        TAC="tac"
    else
        TAC="tail -r"
    fi

    function peco_select {
	LF=$'\\\x0A'
        declare BUFFER=$(history | eval $TAC | awk '!a[$0]++' | peco | cut -d' ' -f5- | sed 's/\\n/'"$LF"'/g')
        READLINE_LINE="${BUFFER}"
        READLINE_POINT=${#BUFFER}
    }
    bind -x '"\C-r": peco_select'
fi

if type pet > /dev/null 2>&1; then
    function prev() {
        PREV=$(echo $(history | tail -n2 | head -n1) | sed 's/[0-9]* //')
        /bin/sh -c "pet new $(printf %q "$PREV")"
    }

    function pet_select() {
        BUFFER=$(pet search --query "$READLINE_LINE")
        READLINE_LINE=$BUFFER
        READLINE_POINT=${#BUFFER}
    }
    bind -x '"\C-p": pet_select'
fi

if type ghq > /dev/null 2>&1 && type peco > /dev/null 2>&1; then
    function ghq_select() {
        BUFFER=$(ghq list --full-path | peco --query "$LBUFFER")
        if [ -n "$BUFFER" ]; then
            command cd "$BUFFER"
        fi
    }
    bind -x '"\C-g": ghq_select'
fi

# Aliases
export LESS="--chop-long-lines --ignore-case --line-numbers --long-prompt --raw-control-chars"
alias  ctop="ctop -i"
alias  diff="colordiff"
alias  egrep="egrep --color=auto"
alias  emacs="emacs -nw"
alias  fgrep="fgrep --color=auto"
alias  glances="glances --theme-white"
alias  grep="grep --color=auto"
alias  mysql="mysql --auto-rehash"
alias  screen="screen -U"

if type direnv > /dev/null 2>&1; then
    alias tmux="direnv exec / tmux"
else
    alias tmux="tmux -2"
fi

if type nvim > /dev/null 2>&1; then
    alias vi="nvim"
    alias vim="nvim"
    alias view="nvim -R"
fi

if type rlwrap > /dev/null 2>&1; then
    alias ocaml="rlwrap ocaml"
fi

# OS type specifled
case "${OSTYPE}" in
    linux*)
        alias  ls="ls --color=auto"
        if [ "/etc/bash_completion.d" ]; then
            for FILE in $(find /etc/bash_completion.d -type f -follow)
            do
                . "$FILE"
            done
        fi

        if [ -f "/usr/share/autojump/autojump.bash" ]; then
            . "/usr/share/autojump/autojump.bash"
        fi

        if [ -d "$HOME/Android/sdk" ]; then
            export ANDROID_HOME="$HOME/Android/sdk"
        fi
        ;;
    darwin*)
        if [ -f "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        BASE_PATH="/usr"
        if type brew > /dev/null 2>&1; then
            BASE_PATH="$(brew --prefix)"
        fi

        if [ "$BASE_PATH/etc/bash_completion.d" ]; then
            for FILE in $(find "$BASE_PATH/etc/bash_completion.d" -type f -follow)
            do
                . "$FILE"
            done
        fi

        alias  ls="ls -FG"
        for DIRECTORY in coreutils findutils gawk gnu-sed gnu-tar gnu-time gnu-which grep make moreutils
        do
            if [ -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnubin" ]; then
                export PATH="$BASE_PATH/opt/$DIRECTORY/libexec/gnubin":$PATH
                if [ "$DIRECTORY" = "coreutils" ]; then
                    alias ls="ls --color=auto"
                fi
            fi
            if [ -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnuman" ]; then
                export MANPATH="$BASE_PATH/opt/$DIRECTORY/libexec/gnuman":$MANPATH
            fi
        done
		for DIRECTORY in gnu-getopt whois
        do
            if [ -d "$BASE_PATH/opt/$DIRECTORY/bin" ]; then
                export PATH="$BASE_PATH/opt/$DIRECTORY/bin":$PATH
            fi
        done

        if [ -f "$BASE_PATH/share/autojump/autojump.bash" ]; then
            . "$BASE_PATH/share/autojump/autojump.bash"
        fi

        if [ -d "/usr/local/sbin" ]; then
            export PATH=$PATH:"/usr/local/sbin"
        fi

        if [ -d "/sw/bin" ]; then
            export PATH="/sw/bin":$PATH
        fi
        if [ -d "/sw/sbin" ]; then
            export PATH="/sw/sbin":$PATH
        fi

        if [ -f "$BASE_PATH/opt/asdf/libexec/asdf.sh" ]; then
            . "$BASE_PATH/opt/asdf/libexec/asdf.sh"
            export ASDF_GOLANG_MOD_VERSION_ENABLED=true
        fi

        if [ -d "$BASE_PATH/opt/mysql-client/bin" ]; then
            export PATH="$BASE_PATH/opt/mysql-client/bin":$PATH
        fi

        if [ -d "$HOME/Library/Android/sdk" ]; then
            export ANDROID_HOME="$HOME/Library/Android/sdk"
        fi
        ;;
esac

# Prompt
if type __git_ps1 > /dev/null 2>&1; then
    precmd() {
        RPROMPT=$(__git_ps1)
        printf "%*s" $(($COLUMNS - ${#PROMPT} - 1)) $RPROMPT
    }
    #PS1='$(tput sc; precmd; tput rc)${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='$(tput sc; precmd; tput rc)\u@\H:$(pwd)% '
fi

# Command line alternatives
if type bat > /dev/null 2>&1; then
    alias cat='bat --plain --pager never --theme "Monokai Extended Light"'
fi
if type delta > /dev/null 2>&1; then
    alias delta='delta --line-numbers --navigate --side-by-side --syntax-theme "OneHalfLight"'
fi
if type eza > /dev/null 2>&1; then
    alias ls="eza --group --icons"
fi
if type hexyl > /dev/null 2>&1; then
    alias hexdump="hexyl"
    alias od="hexyl"
fi
if type rg > /dev/null 2>&1; then
    alias grep="rg"
fi
if type runiq > /dev/null 2>&1; then
    alias uniq="runiq"
fi
if type sp > /dev/null 2>&1; then
    alias sort="sp"
fi
if type tuc > /dev/null 2>&1; then
    alias cut="cut"
fi
if type zoxide > /dev/null 2>&1; then
    if ! (type z > /dev/null 2>&1); then
        eval "$(zoxide init bash)"
    fi
    alias cd="z"
fi

# SSH
if [ -n "$SSH_CONNECTION" ]; then
    if [ -n "$DISPLAY" ] && [ -z "$TMUX" ] && [ -z "$WINDOW" ]; then
        if type fcitx > /dev/null 2>&1; then
            export XMODIFIERS="@im=fcitx"
            export DefaultIMModule=fcitx
            export GTK_IM_MODULE=fcitx
            export QT_IM_MODULE=fcitx

            fcitx -dr
        fi
    fi

#    case "${EUID:-${UID}}" in
#        *)
#            PS1="\[\e[32m\]${PS1}\[\e[0m\]"
#        ;;
#    esac
fi

# Applications
export DOCKER_BUILDKIT=1
if type nvim > /dev/null 2>&1; then
    export SVN_EDITOR=nvim
elif type vim > /dev/null 2>&1; then
    export SVN_EDITOR=vim
elif type vi > /dev/null 2>&1; then
    export SVN_EDITOR=vi
fi

## direnv
if type direnv > /dev/null 2>&1; then
    if ! (type _direnv_hook > /dev/null 2>&1); then
        eval "$(direnv hook bash)"
    fi
fi

## anyenv
if [ -d /opt/anyenv/bin ]; then
    export PATH=$PATH:/opt/anyenv
fi
if type anyenv > /dev/null 2>&1; then
    eval "$(anyenv init -)"
fi

## asdf
if [ -f /opt/asdf/asdf.sh ]; then
    . /opt/asdf/asdf.sh
    export ASDF_GOLANG_MOD_VERSION_ENABLED=true
fi

## ghq
if [ -d /opt/ghq/ghq ]; then
    export PATH=$PATH:/opt/ghq/ghq
fi

## thefuck
if type thefuck > /dev/null 2>&1; then
    if ! (type _direnv_hook > /dev/null 2>&1); then
        PYTHONWARNINGS=ignore
        eval $(thefuck --alias)
        PYTHONWARNINGS=default
    fi
fi

## HashiCorp Packer
if [ -d /opt/hashicorp/packer ]; then
    export PATH=$PATH:/opt/hashicorp/packer
fi

## Apache Drill
if [ -d /opt/apache/apache-drill/bin ]; then
    export PATH=$PATH:/opt/apache/apache-drill/bin
fi

## Real-ESRGAN
if [ -d /opt/realesrgan/realesrgan ]; then
    export PATH=$PATH:/opt/realesrgan/realesrgan
fi

## Python
export PYTHONUTF8=1
export PYTHONDEVMODE=1
export PYTHONIOENCODING=UTF-8
export PYTHONWARNINGS=default
export WORKON_HOME=$HOME/.virtualenvs
if [ -f /etc/bash_completion.d/virtualenvwrapper ]; then
    . /etc/bash_completion.d/virtualenvwrapper
fi

## Go
if type go > /dev/null 2>&1; then
    if [ -z "$GOPATH" ]; then
        export GOPATH=$HOME/go
    fi

    if [ ! -d $GOPATH ]; then
        mkdir -p $GOPATH/bin $GOPATH/pkg $GOPATH/src
    fi

    export GO111MODULE=on
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOBIN
fi

## OCaml
if [ -d $HOME/.opam/opam-init ]; then
    if [ -f $HOME/.opam/opam-init/init.zsh ]; then
        . $HOME/.opam/opam-init/init.zsh
    fi
fi

## JavaScript
if [ -d /opt/nave/bin ]; then
    export PATH=$PATH:/opt/nave/bin
    export NODE_LATEST_VERSION=$(nave latest)

    if [ -d $HOME/.nave/installed/$NODE_LATEST_VERSION/bin ]; then
        export PATH=$PATH:$HOME/.nave/installed/$NODE_LATEST_VERSION/bin
    fi
    if [ -d $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules ]; then
        export NODE_PATH=$NODE_PATH:$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node:$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules
    fi
fi
if [ -d $HOME/.nvm ]; then
    . $HOME/.nvm/nvm.sh
fi
if [ -d $HOME/.nodebrew/current/bin ]; then
    export PATH=$PATH:$HOME/.nodebrew/current/bin
fi

## PHP
if type php > /dev/null 2>&1; then
    alias  vld="php -d vld.active=1 -d vld.execute=0 -f"
    if [ -d /opt/composer ]; then
        export PATH=$PATH:/opt/composer
    fi
    if [ -d /opt/virtphp ]; then
        export PATH=$PATH:/opt/virtphp
    fi
fi

## Kotlin
if [ -d /opt/jetbrains/kotlin-native/bin ]; then
    export PATH=$PATH:/opt/jetbrains/kotlin-native/bin
elif [ -d /opt/jetbrains/kotlinc/bin ]; then
    export PATH=$PATH:/opt/jetbrains/kotlinc/bin
fi

## Swift
if [ -d /opt/apple/swift/usr/bin ]; then
    export PATH=$PATH:/opt/apple/swift/usr/bin
fi

## Rust
if [ -d $HOME/.cargo/bin ]; then
    export PATH=$PATH:$HOME/.cargo/bin
fi

## .NET Core
if [ -d $HOME/dotnet ]; then
    export PATH=$PATH:$HOME/dotnet
fi

## Android
if [ -n $ANDROID_HOME ]; then
    export ANDROID_SDK_ROOT=$ANDROID_HOME

    if [ -d $ANDROID_SDK_ROOT/tools ]; then
        export PATH=$PATH:$ANDROID_SDK_ROOT/tools
    fi
    if [ -d $ANDROID_SDK_ROOT/platform-tools ]; then
        export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
    fi
    if [ -d $ANDROID_SDK_ROOT/ndk ]; then
        export NDK_ROOT=$ANDROID_SDK_ROOT/ndk/ndk
    fi
fi

## cocos2d-x
if [ -d /opt/cocos2d-x/cocos2d-x ]; then
    # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
    if [ -d /opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin ]; then
        export COCOS_CONSOLE_ROOT=/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin
        export PATH=$COCOS_CONSOLE_ROOT:$PATH
    fi

    # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
    if [ -d /opt/cocos2d-x/cocos2d-x/templates ]; then
        export COCOS_TEMPLATES_ROOT=/opt/cocos2d-x/cocos2d-x/templates
        export PATH=$COCOS_TEMPLATES_ROOT:$PATH
    fi

    # Add environment variable ANT_ROOT for cocos2d-x
    if [ -d /usr/share/ant/bin ]; then
        export ANT_ROOT=/usr/share/ant/bin
        export PATH=$ANT_ROOT:$PATH
    fi
fi


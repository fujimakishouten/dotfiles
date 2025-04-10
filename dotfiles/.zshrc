# Language
export LANGUAGE="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LC_COLLATE="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

# Path
if [ -d "/usr/games" ]; then
    export PATH="$PATH:/usr/games"
fi
if [ -d "$HOME/bin" ]; then
    export PATH="$PATH:$HOME/bin"
fi
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# zsh
if [ -f "$HOME/.zshrc.zwc" ]; then
    if [ "$HOME/.zshrc" -nt "$HOME/.zshrc.zwc" ]; then
        zcompile "$HOME/.zshrc"
    fi
else
    zcompile "$HOME/.zshrc"
fi

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

typeset -U path PATH

autoload -Uz colors
autoload -Uz compinit
autoload -Uz vcs_info
autoload -Uz zed
autoload -Uz zmv
colors
compinit -u

setopt aliases
setopt append_history
setopt auto_param_keys
setopt auto_pushd
setopt complete_aliases
setopt complete_in_word
setopt correct
setopt extended_glob
setopt extended_history
setopt glob
setopt glob_complete
setopt globdots
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_save_no_dups
setopt hist_verify
setopt list_types
setopt magic_equal_subst
setopt multios
setopt no_beep
setopt nolistbeep
setopt magic_equal_subst
setopt numeric_glob_sort
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion::complete:*' use-cache true
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'

# Prompt
precmd() {
    vcs_info
    RPROMPT=${vcs_info_msg_0_}
}

PROMPT="%n@%M:%/%% "

# OS type specified
case "${OSTYPE}" in
    linux*)
        alias ls="ls --color=auto"

        if [ -d "/usr/share/zsh-completions" ]; then
            export FPATH=$FPATH:"/usr/share/zsh-completions"
        fi
        if [ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
            . "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        fi
        if [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
            . "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        fi

        if [ -f "/usr/share/autojump/autojump.zsh" ]; then
            . "/usr/share/autojump/autojump.zsh"
        fi

        if [ -d "$HOME/Android/sdk" ]; then
            export ANDROID_HOME="$HOME/Android/sdk"
        fi
        ;;
    darwin*)
        alias ls="ls -FG"

        if [ -f "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi

        BASE_PATH="/usr"
        if type brew >/dev/null 2>&1; then
            BASE_PATH="$(brew --prefix)"
        fi

        if [ -d "$BASE_PATH/share/zsh-completions" ]; then
            export FPATH=$FPATH:"$BASE_PATH/share/zsh-completions"
        fi
        if [ -f "$BASE_PATH/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
            . "$BASE_PATH/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        fi
        if [ -f "$BASE_PATH/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
            . "$BASE_PATH/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        fi

        for DIRECTORY in coreutils findutils gawk gnu-sed gnu-tar gnu-time gnu-which grep make moreutils
        do
            if [ -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnubin" ]; then
                export PATH="$BASE_PATH/opt/$DIRECTORY/libexec/gnubin:$PATH"
                if [ "$DIRECTORY" = "coreutils" ]; then
                    alias ls="ls --color=auto"
                fi
            fi
            if [ -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnuman" ]; then
                export MANPATH="$BASE_PATH/opt/$DIRECTORY/libexec/gnuman:$MANPATH"
            fi
        done

        for DIRECTORY in curl gnu-getopt whois
        do
            if [ -d "$BASE_PATH/opt/$DIRECTORY/bin" ]; then
                export PATH="$BASE_PATH/opt/$DIRECTORY/bin:$PATH"
            fi
        done

        if [ -f "$BASE_PATH/share/autojump/autojump.zsh" ]; then
            . "$BASE_PATH/share/autojump/autojump.zsh"
        fi

        if [ -d "/usr/local/sbin" ]; then
            export PATH="$PATH:/usr/local/sbin"
        fi

        if [ -d "/sw/bin" ]; then
            export PATH="$PATH:/sw/bin"
        fi
        if [ -d "/sw/sbin" ]; then
            export PATH="$PATH/sw/sbin"
        fi

        if [ -d "$HOME/.docker/bin" ]; then
            export PATH="$PATH:$HOME/.docker/bin"
        fi

        if [ -d "$BASE_PATH/opt/mysql-client/bin" ]; then
            export PATH="$PATH:$BASE_PATH/opt/mysql-client/bin"
        fi

        if [ -d "$BASE_PATH/opt/libpq/bin" ]; then
            export PATH="$PATH:$BASE_PATH/opt/libpq/bin"
        fi

        if [ -d "$HOME/Library/Android/sdk" ]; then
            export ANDROID_HOME="$HOME/Library/Android/sdk"
        fi
        ;;
esac

# Key bindings
if type fzf >/dev/null 2>&1; then
    if type tac >/dev/null 2>&1; then
        TAC="tac"
    else
        TAC="tail -r"
    fi

    function fzf_select() {
        BUFFER=$(history -n 1 | $TAC | fzf --ansi --cycle --header-first --no-separator --no-sort --color "light" --layout "reverse" --scheme "history" --tabstop 4 --query "$LBUFFER" --tiebreak "index")
        CURSOR="$#BUFFER"
        zle reset-prompt
    }
    zle -N fzf_select
    bindkey '^R' fzf_select
fi

if type pet >/dev/null 2>&1; then
    function prev() {
        PREV=$(fc -lrn | head -n 1)
        /bin/sh -c "pet new $(printf %q "$PREV")"
    }

    function pet_select() {
        BUFFER=$(pet search --query "$LBUFFER")
        CURSOR="$#BUFFER"
        zle reset-prompt
    }
    zle -N pet_select
    bindkey '^P' pet_select
fi

if type ghq >/dev/null 2>&1; then
    if type fzf >/dev/null 2>&1; then
        function ghq_select() {
            GHQ_SOURCE=$(ghq list --full-path | fzf --ansi --cycle --header-first --no-separator --no-sort --color "light" --layout "reverse" --scheme "history" --tabstop 4 --query "$LBUFFER" --tiebreak "index")
            if [ "$GHQ_SOURCE" ]; then
                BUFFER='cd "'$GHQ_SOURCE'"'
                CURSOR="$#BUFFER"
            fi
            zle reset-prompt
        }
        zle -N ghq_select
        bindkey '^G' ghq_select
    fi
fi

# Aliases
export LESS="--chop-long-lines --ignore-case --line-numbers --long-prompt --raw-control-chars"
alias ctop="ctop -i"
alias egrep="egrep --color=auto"
alias emacs="emacs -nw"
alias fgrep="fgrep --color=auto"
alias glances="glances --theme-white"
alias grep="grep --color=auto"
alias mysql="mysql --auto-rehash"
alias screen="screen -U"
alias tmux="tmux -2"

if type nvim >/dev/null 2>&1; then
    alias vi="nvim"
    alias vim="nvim"
    alias view="nvim -R"
fi

if type rlwrap >/dev/null 2>&1; then
    alias ocaml="rlwrap ocaml"
fi

# Command line alternatives
if type batcat >/dev/null 2>&1; then
    alias cat='batcat --plain --pager never --theme "Monokai Extended Light"'
elif type bat >/dev/null 2>&1; then
    alias cat='bat --plain --pager never --theme "Monokai Extended Light"'
fi
if type delta >/dev/null 2>&1; then
    alias delta='delta --line-numbers --navigate --side-by-side --syntax-theme "OneHalfLight"'
fi
if type colordiff >/dev/null 2>&1; then
    alias diff="colordiff"
fi
if type eza >/dev/null 2>&1; then
    alias ls="eza --group --icons"
fi
if type hexyl >/dev/null 2>&1; then
    alias hexdump="hexyl"
    alias od="hexyl"
fi
if type rg >/dev/null 2>&1; then
    alias grep="rg"
fi
if type runiq >/dev/null 2>&1; then
    alias uniq="runiq"
fi
if type sp >/dev/null 2>&1; then
    alias sort="sp"
fi
if type tuc >/dev/null 2>&1; then
    alias cut="tuc"
fi
if type zoxide >/dev/null 2>&1; then
    if ! (type z >/dev/null 2 >&1); then
        eval "$(zoxide init zsh)"
    fi
    alias cd="z"
fi

# SSH
#if [ -n "$SSH_CONNECTION" ]; then
#    if [ -n "$DISPLAY" ] && [ -z "$TMUX" ] && [ -z "$WINDOW" ]; then
#        if type fcitx > /dev/null 2>&1; then
#            export XMODIFIERS="@im=fcitx"
#            export DefaultIMModule=fcitx
#            export GTK_IM_MODULE=fcitx
#            export QT_IM_MODULE=fcitx
#
#            fcitx -dr
#        fi
#    fi
#
#    case "${EUID:-${UID}}" in
#        *)
#            PROMPT="${fg[green]}${PROMPT}${reset_color}"
#        ;;
#    esac
#fi

# Editor
if type nvim > /dev/null 2>&1; then
    export EDITOR="nvim"
    export SVN_EDITOR="nvim"
elif type vim > /dev/null 2>&1; then
    export EDITOR="vim"
    export SVN_EDITOR="vim"
elif type vi > /dev/null 2>&1; then
    export EDITOR="vi"
    export SVN_EDITOR="vi"
elif type nano >/dev/null 2>&1; then
    export EDITOR="nano"
    export SVN_EDITOR="nano"
fi

# Applications
## docker
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

## direnv
if type direnv >/dev/null 2>&1; then
    if ! (type _direnv_hook >/dev/null 2 >&1); then
        eval "$(direnv hook zsh)"
        alias tmux="direnv exec / tmux"
    fi
fi

## anyenv
if [ -d "/opt/anyenv/bin" ]; then
    export PATH="$PATH:/opt/anyenv/bin"
fi
if type anyenv >/dev/null 2>&1; then
    eval "$(anyenv init -)"
fi

## asdf
if [ -f "/opt/asdf/asdf" ]; then
    export PATH="$PATH:/opt/asdf"
fi
if type asdf >/dev/null 2>&1; then
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
    export ASDF_GOLANG_MOD_VERSION_ENABLED=true
fi

## mise
if type mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

## ghq
if [ -d "/opt/ghq/ghq" ]; then
    export PATH="$PATH:/opt/ghq/ghq"
fi

## thefuck
if type thefuck >/dev/null 2>&1; then
    if [ "$(command -v fuck | cut -c 1)" = "/" ]; then
        PYTHONWARNINGS=ignore
        eval $(thefuck --alias)
        PYTHONWARNINGS=default
    fi
fi

## HashiCorp Packer
if [ -d "/opt/hashicorp/packer" ]; then
    export PATH="$PATH:/opt/hashicorp/packer"
fi

## Apache Drill
if [ -d "/opt/apache/apache-drill/bin" ]; then
    export PATH="$PATH:/opt/apache/apache-drill/bin"
fi

## Real-ESRGAN
if [ -d "/opt/realesrgan/realesrgan" ]; then
    export PATH="$PATH:/opt/realesrgan/realesrgan"
fi

## Python
export PYTHONUTF8=1
export PYTHONDEVMODE=1
export PYTHONIOENCODING="UTF-8"
export PYTHONWARNINGS="default"
export WORKON_HOME="$HOME/.virtualenvs"
if [ -f "/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh" ]; then
    . "/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh"
fi

## Go
if type go >/dev/null 2>&1; then
    if [ -z "$GOPATH" ]; then
        export GOPATH="$HOME/.go"
    fi

    if [ ! -d "$GOPATH" ]; then
        mkdir -p "$GOPATH/bin" "$GOPATH/pkg" "$GOPATH/src"
    fi

    export CGO_ENABLED=0
    export GO111MODULE=on
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN"
fi

## OCaml
if [ -d "$HOME/.opam/opam-init" ]; then
    if [ -f "$HOME/.opam/opam-init/init.zsh" ]; then
        . "$HOME/.opam/opam-init/init.zsh"
    fi
fi

## JavaScript
if [ -d "$HOME/.bun/bin" ]; then
    export PATH="$PATH:$HOME/.bun/bin"
fi
if [ -d "/opt/nave/bin" ]; then
    export PATH="$PATH:/opt/nave/bin"
    export NODE_LATEST_VERSION=$(nave latest)

    if [ -d "$HOME/.nave/installed/$NODE_LATEST_VERSION/bin" ]; then
        export PATH="$PATH:$HOME/.nave/installed/$NODE_LATEST_VERSION/bin"
    fi
    if [ -d "$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules" ]; then
        export NODE_PATH="$NODE_PATH:$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node:$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules"
    fi
fi
if [ -d "$HOME/.nvm" ]; then
    . "$HOME/.nvm/nvm.sh"
fi
if [ -d "$HOME/.nodebrew/current/bin" ]; then
    export PATH="$PATH:$HOME/.nodebrew/current/bin"
fi
if [ -d "$HOME/.volta/bin" ]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$PATH:$VOLTA_HOME/bin"
fi

## PHP
if type php >/dev/null 2>&1; then
    alias vld="php -d vld.active=1 -d vld.execute=0 -f"
    if [ -d "/opt/composer" ]; then
        export PATH="$PATH:/opt/composer"
    fi
    if [ -d "/opt/virtphp" ]; then
        export PATH="$PATH:/opt/virtphp"
    fi
fi

## Kotlin
if [ -d "/opt/jetbrains/kotlin-native/bin" ]; then
    export PATH="$PATH:/opt/jetbrains/kotlin-native/bin"
elif [ -d "/opt/jetbrains/kotlinc/bin" ]; then
    export PATH="$PATH:/opt/jetbrains/kotlinc/bin"
fi

## Swift
if [ -d "/opt/apple/swift/usr/bin" ]; then
    export PATH="$PATH:/opt/apple/swift/usr/bin"
fi

## Rust
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

## .NET Core
if [ -d "$HOME/dotnet" ]; then
    export PATH="$PATH:$HOME/dotnet"
fi

## Android
if [ -n "$ANDROID_HOME" ]; then
    export ANDROID_SDK_ROOT="$ANDROID_HOME"

    if [ -d "$ANDROID_SDK_ROOT/tools" ]; then
        export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
    fi
    if [ -d "$ANDROID_SDK_ROOT/platform-tools" ]; then
        export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
    fi
    if [ -d "$ANDROID_SDK_ROOT/ndk" ]; then
        export NDK_ROOT="$ANDROID_SDK_ROOT/ndk/ndk"
    fi
fi

## cocos2d-x
if [ -d "/opt/cocos2d-x/cocos2d-x" ]; then
    # Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
    if [ -d "/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin" ]; then
        export COCOS_CONSOLE_ROOT="/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin"
        export PATH="$PATH:$COCOS_CONSOLE_ROOT"
    fi

    # Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
    if [ -d "/opt/cocos2d-x/cocos2d-x/templates" ]; then
        export COCOS_TEMPLATES_ROOT="/opt/cocos2d-x/cocos2d-x/templates"
        export PATH="$PATH:$COCOS_TEMPLATES_ROOT"
    fi

    # Add environment variable ANT_ROOT for cocos2d-x
    if [ -d "/usr/share/ant/bin" ]; then
        export ANT_ROOT="/usr/share/ant/bin"
        export PATH="$PATH:$ANT_ROOT"
    fi
fi

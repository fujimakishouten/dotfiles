# Language
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export LC_COLLATE=ja_JP.UTF-8

# Path
if [ -d $HOME/bin ]; then
    export PATH=$PATH:$HOME/bin
fi

# zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

autoload -Uz colors
autoload -Uz compinit
autoload -Uz zed
colors
compinit -u

setopt append_history
setopt auto_pushd
setopt complete_aliases
setopt complete_in_word
setopt correct
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_verify
setopt magic_equal_subst
setopt multios
setopt no_beep
setopt nolistbeep
setopt numeric_glob_sort
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

PROMPT="%n@%M:%/%% "


# Aliases
case "${OSTYPE}" in
    linux*)
        export LESS="--raw-control-chars"

        alias  diff="colordiff"
        alias  egrep="egrep --color=auto"
        alias  emacs="emacs -nw"
        alias  fgrep="fgrep --color=auto"
        alias  grep="grep --color=auto"
        alias  ls="ls --color=auto"
        alias  mysql="mysql --auto-rehash"
        alias  screen="screen -U"
        alias  tmux="tmux -2"

        alias  php6=python3
        alias  vld="php -d vld.active=1 -d vld.execute=0 -f"
 
        if [ -f /usr/bin/nvim ]; then
            alias vi="/usr/bin/nvim"
            alias vim="/usr/bin/nvim"
            alias view="/usr/bin/nvim -R"
        fi

        if [ -f /usr/bin/rlwrap ]; then
            alias ocaml="/usr/bin/rlwrap ocaml"
        fi
        ;;
esac

#case "${UID}" in
#    *)
#        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#            PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
#        ;;
#esac


# Others
export SVN_EDITOR=/usr/bin/vim
if [ -d /opt/hashicorp/packer ]; then
    export PATH=$PATH:/opt/hashicorp/packer
fi

# Python
export PYTHONIOENCODING=UTF-8
export PYTHONHOME=/usr
export WORKON_HOME=$HOME/.virtualenvs
if [ -f /etc/bash_completion.d/virtualenvwrapper ]; then
    . /etc/bash_completion.d/virtualenvwrapper
fi

# Go
if type go > /dev/null 2>&1; then
    if [ -z $GOPATH ]; then
        export GOPATH=$HOME/go
    fi

    if [ ! -d $GOPATH ]; then
        mkdir -p $GOPATH/bin $GOPATH/pkg $GOPATH/src
    fi

    export PATH=$PATH:$GOPATH/bin
fi

# OCaml
if [ -d $HOME/.opam/opam-init ]; then
    if [ -f $HOME/.opam/opam-init/init.zsh ]; then
        . $HOME/.opam/opam-init/init.zsh
    fi
fi

# JavaScript
if [ -d /opt/nave/bin ]; then
    export PATH=$PATH:/opt/nave/bin
    
    NODE_LATEST_VERSION=`nave latest`
    if [ -d $HOME/.nave/installed/$NODE_LATEST_VERSION/bin ]; then
        export PATH=$PATH:$HOME/.nave/installed/$NODE_LATEST_VERSION/bin
    fi
fi
if [ -d $HOME/.nvm ]; then
    . $HOME/.nvm/nvm.sh
fi
if [ -d $HOME/.nodebrew/current/bin ]; then
    export PATH=$PATH:$HOME/.nodebrew/current/bin
fi

# PHP
if [ -d /opt/composer ]; then
    export PATH=$PATH:/opt/composer
fi
if [ -d /opt/virtphp ]; then
    export PATH=$PATH:/opt/virtphp
fi
if [ -d $HOME/.phpenv ]; then
    export PHPENV_ROOT=$HOME/.phpenv
    export PATH=$PATH:$PHPENV_ROOT/bin
    eval "$(phpenv init -)"
fi

# Kotlin
if [ -d /opt/jetbrains/kotlinc/bin ]; then
    export PATH=$PATH:/opt/jetbrains/kotlinc/bin
fi

# Swift
if [ -d /opt/apple/swift/usr/bin ]; then
    export PATH=$PATH:/opt/apple/swift/usr/bin
fi

# Android SDK
if [ -d /opt/google/android-sdk-linux ]; then
    export ANDROID_SDK_ROOT=/opt/google/android-sdk-linux
    export PATH=$PATH:$ANDROID_SDK_ROOT

    if [ -d $ANDROID_SDK_ROOT/tools ]; then
        export PATH=$PATH:$ANDROID_SDK_ROOT/tools
    fi

    if [ -d $ANDROID_SDK_ROOT/platform-tools ]; then
        export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
    fi
fi

# Android NDK
if [ -d /opt/google/android-ndk ]; then
    export NDK_ROOT=/opt/google/android-ndk
    export PATH=$PATH:$NDK_ROOT
fi

# cocos2d-x
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

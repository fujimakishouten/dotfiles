# Language
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=ja_JP.UTF-8

# Path
if [ -d $HOME/bin ]; then
    export PATH=$PATH:$HOME/bin
fi

# zsh
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

autoload -U compinit
autoload -U zed
autoload -U colors
compinit -u

setopt correct
setopt nolistbeep
setopt hist_ignore_all_dups
setopt append_history
setopt extended_history
setopt share_history
setopt auto_pushd
setopt multios
setopt print_eight_bit
setopt prompt_subst
setopt complete_aliases
setopt complete_in_word
setopt numeric_glob_sort

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

PROMPT="%n@%M:%/%% "


# Aliases
case "${OSTYPE}" in
    linux*)
        export LESS="--raw-control-chars"

        alias  ls="ls --color=auto"
        alias  grep="grep --color=auto"
        alias  egrep="egrep --color=auto"
        alias  diff="colordiff"
        alias  screen="screen -U"
        alias  tmux="tmux -2"
        alias  emacs="emacs -nw"
        alias  mysql="mysql --auto-rehash"

        alias  vld="php -d vld.active=1 -d vld.execute=0 -f"

        alias  php6=python3
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
        if [ ! -d $HOME/gocode ]; then
            mkdir -p  $HOME/gocode/bin $HOME/gocode/pkg $HOME/gocode/src
        fi

        export GOPATH=$HOME/gocode
        export PATH=$PATH:$GOPATH/bin
    fi
fi

# JavaScript
if [ -d /opt/nave/bin ]; then
    export PATH=$PATH:/opt/nave/bin
fi
if [ -d $HOME/.nvm ]; then
    . $HOME/.nvm/nvm.sh
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


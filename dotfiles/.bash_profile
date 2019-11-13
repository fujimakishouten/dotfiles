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
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

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

        alias  vld="php -d vld.active=1 -d vld.execute=0 -f"

        if type nvim > /dev/null 2>&1; then
            alias vi="$(/usr/bin/env which nvim)"
            alias vim="$(/usr/bin/env which nvim)"
            alias view="$(/usr/bin/env which nvim) -R"
        fi

        if type rlwrap > /dev/null 2>&1; then
            alias ocaml="$(/usr/bin/env which rlwrap) ocaml"
        fi
        ;;
    darwin*)
        export LESS="--raw-control-chars"

        alias  diff="colordiff"
        alias  egrep="egrep --color=auto"
        alias  emacs="emacs -nw"
        alias  fgrep="fgrep --color=auto"
        alias  grep="grep --color=auto"
        alias  ls="ls -FG"
        alias  mysql="mysql --auto-rehash"
        alias  screen="screen -U"
        alias  tmux="tmux -2"

        alias  php6=python3
        alias  vld="php -d vld.active=1 -d vld.execute=0 -f"

        if [ -d /sw/bin ]; then
            export PATH=/sw/bin:$PATH
        fi
        if [ -d /sw/sbin ]; then
            export PATH=/sw/sbin:$PATH
        fi

        if type nvim > /dev/null 2>&1; then
            alias vi="$(/usr/bin/env which nvim)"
            alias vim="$(/usr/bin/env which nvim)"
            alias view="$(/usr/bin/env which nvim) -R"
        fi

        if type rlwrap > /dev/null 2>&1; then
            alias ocaml="$(/usr/bin/env which rlwrap) ocaml"
        fi
        ;;
esac

#case "${UID}" in
#    *)
#        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#            PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
#        ;;
#esac

# SSH
if [ -n "$SSH_CONNECTION" ]; then
    if [ -n "$DISPLAY" ] && [ -z "$TMUX" ] && [ -z "$WINDOW" ]; then                                                                                                             
        if [ -f /usr/bin/fcitx ]; then
            export XMODIFIERS="@im=fcitx"
            export DefaultIMModule=fcitx
            export GTK_IM_MODULE=fcitx
            export QT_IM_MODULE=fcitx

            fcitx -dr
        fi
    fi
fi

# Others
export DOCKER_BUILDKIT=1
if type nvim > /dev/null 2>&1; then
    export SVN_EDITOR=$(/usr/bin/which nvim)
elif type vim > /dev/null 2&1; then
    export SVN_EDITOR=$(/usr/bin/which vim)
elif type vi > /dev/null 2&1; then
    export SVN_EDITOR=$(/usr/bin/which vi)
fi
if type direnv > /dev/null 2>&1; then
    eval "$(/usr/bin/env direnv hook bash)"
fi
if [ -d /opt/hashicorp/packer ]; then
    export PATH=$PATH:/opt/hashicorp/packer
fi
if [ -d /opt/apache/apache-drill/bin ]; then
    export PATH=$PATH:/opt/apache/apache-drill/bin
fi

# Python
export PYTHONIOENCODING=UTF-8
export WORKON_HOME=$HOME/.virtualenvs
export PYENV_ROOT=$HOME/.pyenv
if [ -f /etc/bash_completion.d/virtualenvwrapper ]; then
    . /etc/bash_completion.d/virtualenvwrapper
fi
if [ -d $PYENV_ROOT/bin ]; then
    export PATH=$PATH:$PYENV_ROOT/bin
    eval "$(pyenv init -)"
    if [ -d $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# Go
if type go > /dev/null 2>&1; then
    if [ -z "$GOPATH" ]; then
        export GOPATH=$HOME/go
    fi

    if [ ! -d $GOPATH ]; then
        mkdir -p $GOPATH/bin $GOPATH/pkg $GOPATH/src
    fi

    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOBIN
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
if [ -d /opt/jetbrains/kotlin-native/bin ]; then
    export PATH=$PATH:/opt/jetbrains/kotlin-native/bin
elif [ -d /opt/jetbrains/kotlinc/bin ]; then
    export PATH=$PATH:/opt/jetbrains/kotlinc/bin
fi

# Swift
if [ -d /opt/apple/swift/usr/bin ]; then
    export PATH=$PATH:/opt/apple/swift/usr/bin
fi

# .NET Core
if [ -d $HOME/dotnet ]; then
    export PATH=$PATH:$HOME/dotnet
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


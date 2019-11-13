# Language
set -x LANGUAGE en_GB.UTF-8
set -x LANG en_GB.UTF-8
set -x LC_ALL en_GB.UTF-8
set -x LC_COLLATE js_JP.UTF-8

# Path
if test -d $HOME/bin
    set -x PATH $PATH $HOME/bin
end
if test -d $HOME/.local/bin
    set -x PATH $PATH $HOME/.local/bin
end

# Prompt
## Fish git prompt
set -x __fish_git_prompt_color_branch black

# Alias
switch (uname)
    case "Linux"
        set -x LESS "--raw-control-chars"

        alias diff "colordiff"
        alias egrep "egrep --color=auto"
        alias emacs "emacs -nw"
        alias fgrep "fgrep --color=auto"
        alias grep "grep --color=auto"
        alias ls "ls --color=auto"
        alias mysql "mysql --auto-rehash"
        alias screen "screen -U"
        alias tmux "tmux -2"

        alias php6 "python3"
        alias vld "php -d vld.active=1 -d vld.execute=0 -f"

        if test -f /usr/bin/nvim
            alias vi "/usr/bin/nvim"
            alias vim "/usr/bin/nvim"
            alias view "/usr/bin/nvim -R"
        end

        if test -f /usr/bin/rlwrap
            alias ocaml "/usr/bin/rlwrap ocaml"
        end

    case "Darwin"
        set -x LESS "--raw-control-chars"

        alias diff "colordiff"
        alias egrep "egrep --color=auto"
        alias emacs "emacs -nw"
        alias fgrep "fgrep --color=auto"
        alias grep "grep --color=auto"
        alias ls "ls -FG"
        alias mysql "mysql --auto-rehash"
        alias screen "screen -U"
        alias tmux "tmux -2"

        alias php6 "python3"
        alias vld "php -d vld.active=1 -d vld.execute=0 -f"

        if test -d /sw/bin
            set -x PATH /sw/bin $PATH
        end
        if test -d /sw/sbin
            set -x PATH /sw/sbin $PATH
        end

        if test -f /sw/bin/nvim
            alias vi "/sw/bin/nvim"
            alias vim "/sw/bin/nvim"
            alias view "/sw/bin/nvim -R"
        end

        if test -f /usr/local/bin/nvim
            alias vi "/usr/local/bin/nvim"
            alias vim "/usr/local/bin/nvim"
            alias view "/usr/local/bin/nvim -R"
        end

        if test -f /usr/bin/rlwrap
            alias ocaml "/usr/bin/rlwrap ocaml"
        end
end

# Others
set -x DOCKER_BUILDKIT 1
if type nvim > /dev/null ^&1
    set -x SVN_EDITOR (which nvim)
else if type vim > /dev/null ^&1
    set -x SVN_EDITOR (which vim)
else if type vi > /dev/null ^&1
    set -x SVN_EDITOR (which vi)
end
if test -d /opt/hashicorp/packer
    set -x PATH $PATH /opt/hashicorp/packer
end
if test -d /opt/apache/apache-drill/bin
    set -x PATH $PATH /opt/apache/apache-drill/bin
end

# Python
set -x PYTHONIOENCODING UTF-8
set -x WORKON_HOME $HOME/.virtualenvs
set -x PYENV_ROOT $HOME/.pyenv
if test -f /etc/bash_completion.d/virtualenvwrapper
    . /etc/bash_completion.d/virtualenvwrapper
end
if test -d $PYENV_ROOT/bin
    set -x PATH $PATH $PYENV_ROOT/bin
    eval "(pyenv init -)"
    if test -d $PYENV_ROOT/plugins/pyenv-virtualenv
        eval "(pyenv virtualenv-init -)"
    end
end

# Go
if type go > /dev/null ^&1
    if test -z $GOPATH
        set -x GOPATH $HOME/go
    end

    if not test -d $GOPATH
        mkdir -p $GOPATH/bin $GOPATH/pkg $GOPATH/src
    end

    set -x GOBIN $GOPATH/bin
    set -x PATH $PATH $GOBIN
end

# OCaml
if test -d $HOME/.opam/opam-init
    if test -f $HOME/.opam/opam-init/init.fish
        . $HOME/.opam/opam-init/init.fish
    end
end

# JavaScript
if test -d /opt/nave/bin
    set -x PATH $PATH /opt/nave/bin
    set -x NODE_LATEST_VERSION (nave latest)
 
    if test -d $HOME/.nave/installed/$NODE_LATEST_VERSION/bin
        set -x PATH $PATH $HOME/.nave/installed/$NODE_LATEST_VERSION/bin
    end
    if test -d $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules
        set -x NODE_PATH $NODE_PATH $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules
    end
end
if test -d $HOME/.nvm
    . $HOME/.nvm/nvm.sh
end
if test -d $HOME/.nodebrew/current/bin
    PATH $PATH $HOME/.nodebrew/current/bin
end

# PHP
if test -d /opt/composer
    set -x PATH $PATH /opt/composer
end
if test -d /opt/virtphp
    set -x PATH $PATH /opt/virtphp
end
if test -d $HOME/.phpenv
    set -x PHPENV_ROOT $HOME/.phpenv
    set -x PATH $PATH $PHPENV_ROOT/bin
    eval "(phpenv init -)"
end

# Kotlin
if test -d /opt/jetbrains/kotlin-native/bin
    set -x PATH $PATH /opt/jetbrains/kotlin-native/bin
else if test -d /opt/jetbrains/kotlinc/bin
    set -x PATH $PATH /opt/jetbrains/kotlinc/bin
end

# Swift
if test -d /opt/apple/swift/usr/bin
    set -x PATH $PATH /opt/apple/swift/usr/bin
end

# .NET Core
if test -d $HOME/dotnet
    set -x PATH $PATH $HOME/dotnet
end

# cocos2d-x
if test -d /opt/cocos2d-x/cocos2d-x
    if test -d /opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin
        set -x COCOS_CONSOLE_ROOT /opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin
        set -x PATH $COCOS_CONSOLE_ROOT $PATH
    end
    if test -d /opt/cocos2d-x/cocos2d-x/templates
        set -x COCOS_TEMPLATES_ROOT /opt/cocos2d-x/cocos2d-x/templates
        set -x PATH $COCOS_CONSOLE_ROOT $PATH
    end
    if test -d /usr/share/ant/bin
        set -x ANT_ROOT /usr/share/ant/bin
        set -x PATH $ANT_ROOT $PATH
    end
end


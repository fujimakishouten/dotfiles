# Language
set -x LANGUAGE "en_GB.UTF-8"
set -x LC_ALL "en_GB.UTF-8"
set -x LC_COLLATE "en_GB.UTF-8"
set -x LANG "en_GB.UTF-8"

# Path
if test -d "/usr/games"
    fish_add_path --append "/usr/games"
end
if test -d "$HOME/bin"
    fish_add_path --append "$HOME/bin"
end
if test -d "$HOME/.local/bin"
    fish_add_path --append "$HOME/.local/bin"
end

# Prompt
set -x __fish_git_prompt_color_branch "$fish_color_normal"

# OS type specified
switch (uname)
    case "Linux"
        alias ls "ls --color=auto"

        if test -f "/usr/share/autojump/autojump.fish"
            source "/usr/share/autojump/autojump.fish"
        end

        if test -d "$HOME/Android/sdk"
            set -x ANDROID_HOME "$HOME/Android/sdk"
        end
    case "Darwin"
        alias ls "ls -FG"

        if test -f "/opt/homebrew/bin/brew"
            eval (/opt/homebrew/bin/brew shellenv)
        end

        set BASE_PATH "/usr"
        if type brew > /dev/null 2>&1
            set BASE_PATH "$(brew --prefix)"
        end

        for DIRECTORY in coreutils findutils gawk gnu-getopt gnu-sed gnu-tar gnu-time gnu-which grep make moreutils
            if test -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnubin"
                fish_add_path "$BASE_PATH/opt/$DIRECTORY/libexec/gnubin"
                if test "$DIRECTORY" = "coreutils"
                    alias ls "ls --color=auto"
                end
            end
            if test -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnuman"
                set -x MANPATH "$BASE_PATH/opt/$DIRECTORY/libexec/gnuman" "$MANPATH"
            end
        end
        for DIRECTORY in curl gnu-getopt whois
            if test -d "$BASE_PATH/opt/$DIRECTORY/bin"
                fish_add_path "$BASE_PATH/opt/$DIRECTORY/bin"
            end
        end

        if test -f "$BASE_PATH/share/autojump/autojump.fish"
            source "$BASE_PATH/share/autojump/autojump.fish"
        end

        if test -d "/usr/local/sbin"
            fish_add_path --append "/usr/local/sbin"
        end

        if test -d "/sw/bin"
            fish_add_path --append "/sw/bin"
        end
        if test -d "/sw/sbin"
            fish_add_path --append "/sw/sbin"
        end

        if test -d "$HOME/.docker/bin"
            fish_add_path --append "$HOME/.docker/bin"
        end

        if test -d "$BASE_PATH/opt/mysql-client/bin"
            fish_add_path --append "$BASE_PATH/opt/mysql-client/bin"
        end

        if test -d "$BASE_PATH/opt/libpq/bin"
            fish_add_path --append "$BASE_PATH/opt/libpq/bin"
        end

        if test -d "$HOME/Library/Android/sdk"
            set -x ANDROID_HOME "$HOME/Library/Android/sdk"
        end
end

## Key bindings
if type fzf > /dev/null 2>&1
    function fish_user_key_bindings
        bind \cr fzf_select
        bind \cp pet_select
        bind \cg ghq_select
    end
end

# Alias
set -x LESS "--raw-control-chars"
alias ctop "ctop -i"
alias egrep "egrep --color=auto"
alias emacs "emacs -nw"
alias fgrep "fgrep --color=auto"
alias glances "glances --theme-white"
alias grep "grep --color=auto"
alias mysql "mysql --auto-rehash"
alias screen "screen -U"
alias tmux "tmux -2"

if type nvim > /dev/null 2>&1
    alias vi "nvim"
    alias vim "nvim"
    alias view "nvim -R"
end

if type rlwrap > /dev/null 2>&1
    alias ocaml "rlwrap ocaml"
end

# Command line alternatives
if type batcat > /dev/null 2>&1
    alias cat='batcat --plain --pager never --theme "Monokai Extended Light"'
else if type bat > /dev/null 2>&1
    alias cat='bat --plain --pager never --theme "Monokai Extended Light"'
end
if type delta > /dev/null 2>&1
    alias delta='delta --line-numbers --navigate --side-by-side --syntax-theme "OneHalfLight"'
end
if type colordiff > /dev/null 2>&1
    alias diff "colordiff"
end
if type eza > /dev/null 2>&1
    alias ls="eza --group --icons"
end
if type hexyl > /dev/null 2>&1
    alias hexdump="hexyl"
    alias od="hexyl"
end
if type rg > /dev/null 2>&1
    alias grep="rg"
end
if type runiq > /dev/null 2>&1
    alias uniq="runiq"
end
if type sp > /dev/null 2>&1
    alias sort="sp"
end
if type tuc > /dev/null 2>&1
    alias cut="tuc"
end
if type zoxide > /dev/null 2>&1
    if ! type z > /dev/null 2>&1
        zoxide init fish | source
    end
    alias cd="z"
end

# SSH
#if test -n "$SSH_CONNECTION"
#    if test -n "$DISPLAY"; and test -z "$TMUX"; and -z "$WINDOW"
#        if type fcitx > /dev/null 2>&1
#            set -x XMODIFIERS "@im=fcitx"
#            set -x DefaultIMModule fcitx
#            set -x GTK_IM_MODULE fcitx
#            set -x QT_IM_MODULE fcitx
#
#            fcitx -dr
#        end
#    end
#end

# Editor
if type nvim > /dev/null 2>&1
    set -x EDITOR "nvim"
    set -x SVN_EDITOR "nvim"
else if type vim > /dev/null 2>&1
    set -x EDITOR "vim"
    set -x SVN_EDITOR "vim"
else if type vi > /dev/null 2>&1
    set -x EDITOR "vi"
    set -x SVN_EDITOR "vi"
else if type nano > /dev/null 2>&1
    set -x EDITOR "nano"
    set -x SVN_EDITOR "nano"
end

# Applications
## docker
set -x COMPOSE_DOCKER_CLI_BUILD 1
set -x DOCKER_BUILDKIT 1

## direnv
if type direnv > /dev/null 2>&1
    if ! type _direnv_hook > /dev/null 2>&1
        eval (direnv hook fish)
        alias tmux "direnv exec / tmux"
    end
end

## anyenv
if test -d "/opt/anyenv/bin"
    fish_add_path --append "/opt/anyenv/bin"
end
if type anyenv > /dev/null 2>&1
    eval (anyenv init - fish | source)
end

## asdf
if test -f "/opt/asdf"
    fish_add_path --append "/opt/asdf"
end
if type asdf > /dev/null 2>&1
    if test -z "$ASDF_DATA_DIR"
        fish_add_path "$HOME/.asdf/shims"
    else
        fish_add_path "$ASDF_DATA_DIR/shims"
    end
    set -x ASDF_GOLANG_MOD_VERSION_ENABLED true
end

## mise
if type mise > /dev/null 2>&1
    mise activate fish | source
end

## ghq
if test -d "/opt/ghq/ghq"
    fish_add_path --append "/opt/ghq/ghq"
end

### thefuck
if type thefuck > /dev/null 2>&1
    if test (command -v fuck | cut -c 1) = "/"
        PYTHONWARNINGS=ignore eval (thefuck --alias | source)
    end
end

## HashiCorp Packer
if test -d /opt/hashicorp/packer
    fish_add_path --append "/opt/hashicorp/packer"
end

## Apache Drill
if test -d "/opt/apache/apache-drill/bin"
    fish_add_path --append "/opt/apache/apache-drill/bin"
end

## Real-ESRGAN
if test -d "/opt/realesrgan/realesrgan"
    fish_add_path --append "/opt/realesrgan/realesrgan"
end

## Python
set -x PYTHONUTF8 1
set -x PYTHONDEVMODE 1
set -x PYTHONIOENCODING "UTF-8"
set -x PYTHONWARNINGS "default"
set -x WORKON_HOME "$HOME/.virtualenvs"
#if test -f "/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh"
#    source "/usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh"
#end

## Go
if type go > /dev/null 2>&1
    if test -z "$GOPATH"
        set -x GOPATH "$HOME/.go"
    end

    if not test -d "$GOPATH"
        mkdir -p "$GOPATH/bin" "$GOPATH/pkg" "$GOPATH/src"
    end

    set -x GO111MODULE on
    set -x GOBIN "$GOPATH/bin"
    fish_add_path --append "$GOBIN"
end

## OCaml
if test -d "$HOME/.opam/opam-init"
    if test -f "$HOME/.opam/opam-init/init.fish"
        source "$HOME/.opam/opam-init/init.fish"
    end
end

## JavaScript
if test -d "$HOME/.bun/bin"
    fish_add_path --append "$HOME/.bun/bin"
end
if test -d "/opt/nave/bin"
    fish_add_path --append "/opt/nave/bin"
    set -x NODE_LATEST_VERSION (nave latest)

    if test -d "$HOME/.nave/installed/$NODE_LATEST_VERSION/bin"
        fish_add_path --append "$HOME/.nave/installed/$NODE_LATEST_VERSION/bin"
    end
    if test -d "$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules"
        set -x NODE_PATH "$NODE_PATH $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules"
    end
end
if test -d "$HOME/.nvm"
    source "$HOME/.nvm/nvm.sh"
end
if test -d "$HOME/.nodebrew/current/bin"
    fish_add_path --append "$HOME/.nodebrew/current/bin"
end
if test -d "$HOME/.volta/bin"
    set -x VOLTA_HOME "$HOME/.volta"
    fish_add_path --append "$VOLTA_HOME/bin"
end

## PHP
if type php > /dev/null 2>&1
    alias vld "php -d vld.active=1 -d vld.execute=0 -f"
    if test -d "/opt/composer"
        fish_add_path --append "/opt/composer"
    end
    if test -d "/opt/virtphp"
        fish_add_path --append "/opt/virtphp"
    end
end

## Kotlin
if test -d "/opt/jetbrains/kotlin-native/bin"
    fish_add_path --append "/opt/jetbrains/kotlin-native/bin"
else if test -d "/opt/jetbrains/kotlinc/bin"
    fish_add_path --append "/opt/jetbrains/kotlinc/bin"
end

## Swift
if test -d "/opt/apple/swift/usr/bin"
    fish_add_path --append "/opt/apple/swift/usr/bin"
end

## Rust
if test -d "$HOME/.cargo/bin"
    fish_add_path --append "$HOME/.cargo/bin"
end

## .NET Core
if test -d "$HOME/dotnet"
    fish_add_path --append "$HOME/dotnet"
end

## Android
if test -n "$ANDROID_HOME"
    set -x ANDROID_SDK_ROOT "$ANDROID_HOME"
    if test -d "$ANDROID_SDK_ROOT/tools"
        fish_add_path --append "$ANDROID_SDK_ROOT/tools"
    end
    if test -d "$ANDROID_SDK_ROOT/platform-tools"
        fish_add_path --append "$ANDROID_SDK_ROOT/platform-tools"
    end
    if test -d "$ANDROID_SDK_ROOT/ndk"
        set -x NDK_ROOT "$ANDROID_SDK_ROOT/ndk"
    end
end

## cocos2d-x
if test -d "/opt/cocos2d-x/cocos2d-x"
    if test -d "/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin"
        set -x COCOS_CONSOLE_ROOT "/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin"
        fish_add_path --append "$COCOS_CONSOLE_ROOT"
    end
    if test -d "/opt/cocos2d-x/cocos2d-x/templates"
        set -x COCOS_TEMPLATES_ROOT "/opt/cocos2d-x/cocos2d-x/templates"
        fish_add_path --append "$COCOS_CONSOLE_ROOT"
    end
    if test -d "/usr/share/ant/bin"
        set -x ANT_ROOT "/usr/share/ant/bin"
        fish_add_path --append "$ANT_ROOT"
    end
end

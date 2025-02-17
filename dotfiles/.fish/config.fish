# Language
set -x LANGUAGE "en_GB.UTF-8"
set -x LC_ALL "en_GB.UTF-8"
set -x LC_COLLATE "en_GB.UTF-8"
set -x LANG en_GB.UTF-8

# Path
if test -d "/usr/games"
    set -x PATH "$PATH" "/usr/games"
end
if test -d "$HOME/bin"
    set -x PATH "$PATH" "$HOME/bin"
end
if test -d "$HOME/.local/bin"
    set -x PATH "$PATH" "$HOME/.local/bin"
end

## Key bindings
if type fzf > /dev/null 2>&1
    function fish_user_key_bindings
        bind \cr fzf_select
        bind \cp pet_select
        bind \cg ghq_select
    end
end

# Prompt
## Fish git prompt
set -x __fish_git_prompt_color_branch "$fish_color_normal"

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
        if test -f "/opt/homebrew/bin/brew"
            eval (/opt/homebrew/bin/brew shellenv)
        end

        set BASE_PATH "/usr"
        if type brew > /dev/null 2>&1
            set BASE_PATH "$(brew --prefix)"
        end

        alias ls "ls -FG"
        for DIRECTORY in coreutils findutils gawk gnu-getopt gnu-sed gnu-tar gnu-time gnu-which grep make moreutils
            if test -d "$BASE_PATH/opt/$DIRECTORY/libexec/gnubin"
                set -x PATH "$BASE_PATH/opt/$DIRECTORY/libexec/gnubin" "$PATH"
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
                set -x PATH "$BASE_PATH/opt/$DIRECTORY/bin" "$PATH"
            end
        end

        if test -f "$BASE_PATH/share/autojump/autojump.fish"
            source "$BASE_PATH/share/autojump/autojump.fish"
        end

        if test -d "/usr/local/sbin"
            set -x PATH "$PATH" "/usr/local/sbin"
        end

        if test -d "/sw/bin"
            set -x PATH "/sw/bin" "$PATH"
        end
        if test -d "/sw/sbin"
            set -x PATH "/sw/sbin" "$PATH"
        end

        if test -d "$BASE_PATH/opt/mysql-client/bin"
            set -x PATH "$BASE_PATH/opt/mysql-client/bin" "$PATH"
        end

        if test -d "$HOME/Library/Android/sdk"
            set -x ANDROID_HOME "$HOME/Library/Android/sdk"
        end
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

# Applications
set -x DOCKER_BUILDKIT 1
if type nvim > /dev/null 2>&1
    set -x SVN_EDITOR "nvim"
else if type vim > /dev/null 2>&1
    set -x SVN_EDITOR "vim"
else if type vi > /dev/null 2>&1
    set -x SVN_EDITOR "vi"
end

## direnv
if type direnv > /dev/null 2>&1
    if ! type _direnv_hook > /dev/null 2>&1
        eval (direnv hook fish)
        alias tmux "direnv exec / tmux"
    end
end

## anyenv
if test -d /opt/anyenv/bin
    set -x PATH $PATH /opt/anyenv/bin
end
if type anyenv > /dev/null 2>&1
    eval (anyenv init - fish | source)
end

## asdf
if test -f "/opt/asdf/asdf"
    set -x PATH "$PATH" "/opt/asdf"
end
if type asdf > /dev/null 2>&1
    if test -z "$ASDF_DATA_DIR"
        set -x --prepend PATH "$HOME/.asdf/shims"
    else
        set -x --prepend PATH "$ASDF_DATA_DIR/shims"
    end
    set -x ASDF_GOLANG_MOD_VERSION_ENABLED true
end

## mise
if type mise > /dev/null 2>&1
    mise activate fish | source
end

## ghq
if test -d "/opt/ghq/ghq"
    set -x PATH "$PATH" "/opt/ghq/ghq"
end

### thefuck
if type thefuck > /dev/null 2>&1
    if test (command -v fuck | cut -c 1) = "/"
        PYTHONWARNINGS=ignore eval (thefuck --alias | source)
    end
end

## HashiCorp Packer
if test -d /opt/hashicorp/packer
    set -x PATH "$PATH" "/opt/hashicorp/packer"
end

## Apache Drill
if test -d "/opt/apache/apache-drill/bin"
    set -x PATH "$PATH" "/opt/apache/apache-drill/bin"
end

## Real-ESRGAN
if test -d "/opt/realesrgan/realesrgan"
    set -x PATH "$PATH" "/opt/realesrgan/realesrgan"
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
    set -x PATH "$PATH" "$GOBIN"
end

## OCaml
if test -d "$HOME/.opam/opam-init"
    if test -f "$HOME/.opam/opam-init/init.fish"
        source "$HOME/.opam/opam-init/init.fish"
    end
end

## JavaScript
if test -d "/opt/nave/bin"
    set -x PATH "$PATH" "/opt/nave/bin"
    set -x NODE_LATEST_VERSION (nave latest)

    if test -d "$HOME/.nave/installed/$NODE_LATEST_VERSION/bin"
        set -x PATH "$PATH $HOME/.nave/installed/$NODE_LATEST_VERSION/bin"
    end
    if test -d "$HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules"
        set -x NODE_PATH "$NODE_PATH $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node $HOME/.nave/installed/$NODE_LATEST_VERSION/lib/node_modules"
    end
end
if test -d "$HOME/.nvm"
    source "$HOME/.nvm/nvm.sh"
end
if test -d "$HOME/.nodebrew/current/bin"
    set -x PATH "$PATH" "$HOME/.nodebrew/current/bin"
end
if test -d "$HOME/.volta/bin"
    set -x VOLTA_HOME "$HOME/.volta"
    set -x PATH "$PATH" "$VOLTA_HOME/bin"
end

## PHP
if type go > /dev/null 2>&1
    alias vld "php -d vld.active=1 -d vld.execute=0 -f"
    if test -d "/opt/composer"
        set -x PATH "$PATH" "/opt/composer"
    end
    if test -d "/opt/virtphp"
        set -x PATH "$PATH" "/opt/virtphp"
    end
end

## Kotlin
if test -d "/opt/jetbrains/kotlin-native/bin"
    set -x PATH "$PATH" "/opt/jetbrains/kotlin-native/bin"
else if test -d "/opt/jetbrains/kotlinc/bin"
    set -x PATH "$PATH" "/opt/jetbrains/kotlinc/bin"
end

## Swift
if test -d "/opt/apple/swift/usr/bin"
    set -x PATH "$PATH" "/opt/apple/swift/usr/bin"
end

## Rust
if test -d "$HOME/.cargo/bin"
    set -x PATH "$PATH" "$HOME/.cargo/bin"
end

## .NET Core
if test -d "$HOME/dotnet"
    set -x PATH "$PATH" "$HOME/dotnet"
end

## Android
if test -n "$ANDROID_HOME"
    set -x ANDROID_SDK_ROOT "$ANDROID_HOME"
    if test -d "$ANDROID_SDK_ROOT/tools"
        set -x PATH "$PATH" "$ANDROID_SDK_ROOT/tools"
    end
    if test -d "$ANDROID_SDK_ROOT/platform-tools"
        set -x PATH "$PATH" "$ANDROID_SDK_ROOT/platform-tools"
    end
    if test -d "$ANDROID_SDK_ROOT/ndk"
        set -x NDK_ROOT "$ANDROID_SDK_ROOT/ndk"
    end
end

## cocos2d-x
if test -d "/opt/cocos2d-x/cocos2d-x"
    if test -d "/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin"
        set -x COCOS_CONSOLE_ROOT "/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin"
        set -x PATH "$COCOS_CONSOLE_ROOT" "$PATH"
    end
    if test -d "/opt/cocos2d-x/cocos2d-x/templates"
        set -x COCOS_TEMPLATES_ROOT "/opt/cocos2d-x/cocos2d-x/templates"
        set -x PATH "$COCOS_CONSOLE_ROOT" "$PATH"
    end
    if test -d "/usr/share/ant/bin"
        set -x ANT_ROOT "/usr/share/ant/bin"
        set -x PATH "$ANT_ROOT" "$PATH"
    end
end

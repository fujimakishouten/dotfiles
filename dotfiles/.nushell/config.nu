# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# Language
$env.LANG = "en_GB.UTF-8"
$env.LC_ALL = "en_GB.UTF-8"
$env.LC_COLLATE = "en_GB.UTF-8"
$env.LANG = "en_GB.UTF-8"

# Path
if ("/usr/games" | path exists) {
    $env.PATH = ($env.PATH | append "/usr/games" | uniq)
}
if ($"($env.HOME)/bin" | path exists) {
    $env.PATH = ($env.PATH | append $"($env.HOME)/bin" | uniq)
}
if ($"($env.HOME)/.local/bin" | path exists) {
    $env.PATH = ($env.PATH | append $"($env.HOME)/.local/bin" | uniq)
}

# Nushell
$env.config = {
  show_banner: false
}

# Prompt
def prompt [] {
    let user = $env.USER
    let hostname = (sys host | get hostname)
    let cwd = $env.PWD

    $"(ansi grey)($user)@($hostname):($cwd)(ansi reset) "
}
def vcs_info [] {
    if (do { git rev-parse --is-inside-work-tree } | complete).exit_code == 0 {
        let branch = (git branch --show-current | str trim)
        let status = if ((git status --porcelain | str trim | str length) > 0) { "*" } else { "" }
        $"(ansi grey)\(($branch)($status)\)(ansi reset)"
    } else {
        ""
    }
}
$env.PROMPT_COMMAND = { prompt }
$env.PROMPT_COMMAND_RIGHT = { vcs_info }

# OS type specifled
$env.OSTYPE = (sys host | get name)
if $env.OSTYPE =~ "linux" {
    if ($"($env.HOME)/Android/sdk" | path exists) {
        $env.ANDROID_HOME = $"($env.HOME)/Android/sdk"
    }
}
if $env.OSTYPE =~ "Darwin" {
    if ("/opt/homebrew/bin/brew" | path exists) {
        let brew_env = (/opt/homebrew/bin/brew shellenv | lines |
            filter {|line| $line =~ "^export " } |
            str replace "export " "" |
            parse "{name}={value}" |
            update value {|r| $r.value | str replace --all '"' "" })
        load-env ($brew_env | transpose -r -d)
    }

    $env.BASE_PATH = "/usr"
    if not (which brew | is-empty) {
        $env.BASE_PATH = (brew --prefix | str trim)
    }

    for $DIRECTORY in ["coreutils", "findutils", "gawk", "gnu-sed", "gnu-tar", "gnu-time", "gnu-which", "grep", "make", "moreutils"] {
        if ($"($env.BASE_PATH)/opt/($DIRECTORY)/libexec/gnubin" | path exists) {
            $env.PATH = ($env.PATH | prepend $"($env.BASE_PATH)/opt/($DIRECTORY)/libexec/gnubin"  | uniq)
        }
        if ($"($env.BASE_PATH)/opt/($DIRECTORY)/libexec/gnuman" | path exists) {
            $env.MANPATH = ($env | get -i MANPATH | default [] | prepend $"($env.BASE_PATH)/opt/($DIRECTORY)/libexec/gnuman" | uniq)
        }
    }

    for $DIRECTORY in ["curl", "gnu-getopt", "whois"] {
        if ($"($env.BASE_PATH)/opt/($DIRECTORY)/bin" | path exists) {
            $env.PATH = ($env.PATH | prepend $"($env.BASE_PATH)/opt/($DIRECTORY)/bin" | uniq)
        }
    }

    if ("/usr/local/sbin" | path exists) {
        $env.PATH = ($env.PATH | append "/usr/local/bin" | uniq)
    }

    if ("/sw/bin" | path exists) {
        $env.PATH = ($env.PATH | prepend "/sw/bin" | uniq)
    }
    if ("/sw/sbin" | path exists) {
        $env.PATH = ($env.PATH | prepend "/sw/sbin" | uniq)
    }

    if ($"($env.BASE_PATH)/opt/mysql-client/bin" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.BASE_PATH)/opt/mysql-client/bin" | uniq)
    }

    if ($"($env.BASE_PATH)/opt/libpq/bin" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.BASE_PATH)/opt/libpq/bin" | uniq)
    }

    if ($"($env.HOME)/.docker/bin" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.HOME)/.docker/bin" | uniq)
    }

    if ($"($env.HOME)/Library/Android/sdk" | path exists) {
        $env.ANDROID_HOME = $"($env.HOME)/Library/Android/sdk"
    }
}

# Alias
$env.LESS = "--chop-long-lines --ignore-case --line-numbers --long-prompt --raw-control-chars"
alias  ctop = ctop -i
alias  egrep = egrep --color=auto
alias  emacs = emacs -nw
alias  fgrep = fgrep --color=auto
alias  glances = glances --theme-white
alias  grep = grep --color=auto
alias  mysql = mysql --auto-rehash
alias  screen = screen -U
alias  tmux = tmux -2

if not (which nvim | is-empty) {
    alias vi = nvim
    alias vim = nvim
    alias view = nvim -R
}

if not (which rlwrap | is-empty) {
    alias ocaml = rlwrap ocaml
}

# Command line alternatives
if not (which batcat | is-empty) {
    alias cat = batcat --plain --pager never --theme "Monokai Extended Light"
} else if not (which bat | is-empty) {
    alias cat = bat --plain --pager never --theme "Monokai Extended Light"
}
if not (which delta | is-empty) {
    alias delta = delta --line-numbers --navigate --side-by-side --syntax-theme "OneHalfLight"
}
if not (which colordiff | is-empty) {
    alias diff = colordiff
}
if not (which eza | is-empty) {
    alias ls = eza --group --icons
}
if not (which hexyl | is-empty) {
    alias hexdump = hexyl
    alias od = hexyl
}
if not (which rg | is-empty) {
    alias grep = rg
}
if not (which runiq | is-empty) {
    alias uniq = runiq
}
if not (which sp | is-empty) {
    alias sort = sp
}
if not (which tac | is-empty) {
    alias cut = tuc
}
if not (which zoxide | is-empty) {
}

# Application
$env.DOCKER_BUILDKIT = 1
if not (which nvim | is-empty) {
    $env.EDITOR = "nvim"
    $env.SVN_EDITOR = "nvim"
} else if not (which vim | is-empty) {
    $env.EDITOR = "vim"
    $env.SVN_EDITOR = "vim"
} else if not (which vi | is-empty) {
    $env.EDITOR = "vi"
    $env.SVN_EDITOR = "vi"
} else if not (which nano | is-empty) {
    $env.EDITOR = "nano"
    $env.SVN_EDITOR = "nano"
}

## direnv
$env.config = {
    hooks: {
        pre_prompt: [{ ||
            if (which direnv | is-empty) {
                return
            }

            direnv export json | from json | default {} | load-env
            if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
                $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
            }
        }]
    }
}

## anyenv
if not (which anyenv | is-empty) {
    def --env anyenv-init [] {
        let init_cmd = (anyenv init - | str trim)
        let path_lines = ($init_cmd | lines | filter {|line| $line =~ "PATH="})
        if ($path_lines | length) > 0 {
            let path_str = ($path_lines | first | str replace "PATH=" "" | str replace -a "\"" "")
            let path_list = ($path_str | split row ":")
            $env.PATH = ($path_list | append $env.PATH | uniq)
        }
    }
    anyenv-init
}

## asdf
if ("/opt/asdf/asdf" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/asdf")
}
if not (which asdf | is-empty) {
    if ($env | columns | any {|col| $col == "ASDF_DATA_DIR"}) {
        $env.PATH = ($"($env.ASDF_DATA_DIR)/.asdf/shims" | append $env.PATH | uniq)
    } else {
        $env.PATH = ($"($env.HOME)/.asdf/shims" | append $env.PATH | uniq)
    }
}

## ghq
if ("/opt/ghq/ghq" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/ghq/ghq")
}

## thfuck

## HashiCorp Packer
if ("/opt/hashicorp/packer" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/hashicorp/packer")
}

## Apache Drill
if ("/opt/apache/apache-drill/bin" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/apache/apache-drill/bin")
}

## Real-ESRGAN
if ("/opt/realesrgan/realesrgan" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/realesrgan/realesrgan")
}

## Python
$env.PYTHONUTF8 = 1
$env.PYTHONDEVMODE = 1
$env.PYTHONIOENCODING = "UTF-8"
$env.PYTHONWARNINGS = "default"
$env.WORKON_HOME = $"($env.HOME)/.virtualenvs"

## Go
if not (which go | is-empty) {
    if ($env | columns | any {|col| $col == "GOPATH"}) {
        $env.GOPATH = $"($env.HOME)/.go"
    }

    if not ($"($env.GOPATH)" | path exists) {
        mkdir $"($env.GOPATH)/bin" $"($env.GOPATH)/pkg" $"(env.GOPATH/src)"
    }

    $env.GO111MODULE = "on"
    $env.GOBIN = $"($env.GOPATH)/bin"
    $env.PATH = ($env.PATH | append $"($env.GOBIN)" | uniq)
}

## OCaml

## JavaScript
if ($"($env.HOME)/.bun/bin" | path exists) {
    $env.PATH = ($env.PATH | append $"($env.HOME)/.bun/bin")
}
if ("/opt/nave/bin" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/nave/bin")
    $env.NODE_LATEST_VERSION = (nave latest)

    if ($"($env.HOME)/.nave/installed/($env.NODE_LATEST_VERSION)/bin" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.HOME)/.nave/installed/($env.NODE_LATEST_VERSION)/bin" | uniq)
    }
    if ($"($env.HOME)/.nave/installed/($env.NODE_LATEST_VERSION)/lib/node_modules" | path exists) {
        $env.NODE_PATH = ($env.NODE_PATH | append $"($env.HOME)/.nave/installed/($env.NODE_LATEST_VERSION)/lib/node" | uniq)
        $env.NODE_PATH = ($env.NODE_PATH | append $"($env.HOME)/.nave/installed/($env.NODE_LATEST_VERSION)/lib/node_modules" | uniq)
    }
}
if ($"($env.HOME)/.nodebrew/current/bin" | path exists) {
    $env.PATH = ($env.PATH | append $"($env.HOME)/.nodebrew/current/bin" | uniq)
}
if ($"($env.HOME)/.volta/bin" | path exists) {
    $env.VOLTA_HOME = $"($env.HOME)/.volta"
    $env.PATH = ($env.PATH | append $"($env.VOLTA_HOME)/bin" | uniq)
}

## PHP
if not (which php | is-empty) {
    alias vld = php -d vld.acive=1 -d vld.execute=0 -f
    if ("/opt/comoser" | path exists) {
        $env.PATH = ($env.PATH | append "/opt/composer")
    }
    if ("/opt/virtphp" | path exists) {
        $env.PATH = ($env.PATH | append "/opt/virtphp")
    }
}

## Kotlin
if ("/opt/jetbrains/kotlin-native/bin" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/jetbrains/kotlin-native/bin")
} else if ("/opt/jetbrains/kotlinc/bin" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/jetbrains/kotlinc/bin")
}

## Swift
if ("/opt/apple/swift/usr/bin" | path exists) {
    $env.PATH = ($env.PATH | append "/opt/apple/swift")
}

## Rust
if ($"($env.HOME)/.cargo/bin" | path exists) {
    $env.PATH = ($env.PATH | append $"($env.HOME)/.cargo/bin" | uniq)
}

## .NET Core
if ($"($env.HOME)/dotnet" | path exists) {
    $env.PATH = ($env.PATH | append $"($env.HOME)/dotnet" | uniq)
}

## Android
 if ($env | columns | any {|col| $col == "ANDROID_HOME"}) {
    $env.ANDROID_SDK_ROOT = $"($env.ANDROID_HOME)"

    if ($"($env.ANDROID_SDK_ROOT)/tools" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.ANDROID_SDK_ROOT)/tools" | uniq)
    }
    if ($"($env.ANDROID_SDK_ROOT)/platform-tools" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.ANDROID_SDK_ROOT)/platform-tools" | uniq)
    }
    if ($"($env.ANDROID_SDK_ROOT)/ndk" | path exists) {
        $env.PATH = ($env.PATH | append $"($env.ANDROID_SDK_ROOT)/ndk" | uniq)
    }
 }

## cocos2d-x
if ("/opt/cocos2d-x/cocos2d-x" | path exists) {
    if ("/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin" | path exists) {
        $env.COCOS_CONSOLE_ROOT = "/opt/cocos2d-x/cocos2d-x/tools/cocos2d-console/bin"
        $env.PATH = ($env.PATH | append $"($env.COCOS_CONSOLE_ROOT)" | uniq)
    }
    if ("/opt/cocos2d-x/cocos2d-x/templates" | path exists) {
        $env.COCOS_TEMPLATES_ROOT = "/opt/cocos2d-x/cocos2d-x/templates"
        $env.PATH = ($env.PATH | append $"($env.COCOS_TEMPLATES_ROOT)" | uniq)
    }
    if ("/usr/share/ant/bin" | path exists) {
        $env.ANT_ROOT = "/usr/share/ant/bin"
        $env.PATH = ($env.PATH | append $"($env.ANT_ROOT)" | uniq)
    }
}


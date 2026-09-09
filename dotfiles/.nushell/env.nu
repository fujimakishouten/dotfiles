# env.nu
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

# mise
let mise_config_path = $nu.default-config-dir | path join "mise.nu"
if not (which mise | is-empty) {
    ^mise activate nu | save $mise_config_path --force
} else {
    "" | save $mise_config_path --force
}


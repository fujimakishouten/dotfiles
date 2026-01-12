-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

----------------------------------------------------------------------

local schemes = wezterm.color.get_builtin_schemes()
local scheme = "Ayu Light (Gogh)"
local cols = 120
local rows = 24
if wezterm.target_triple:find("darwin") then
    cols = 148
    rows = 32
end

----------------------------------------------------------------------

config.automatically_reload_config = true

config.exit_behavior = "Close"
config.use_fancy_tab_bar = true
config.use_ime = true
-- config.use_resize_increments = false
config.window_decorations = "RESIZE"

config.initial_cols = cols
config.initial_rows = rows

config.enable_scroll_bar = true
config.scrollback_lines = 20000

config.default_cwd = os.getenv("HOME")

config.font = wezterm.font("VL NF")
config.font_size = 18.0
config.line_height = 1.2

config.color_scheme = "ayu_light"
config.color_scheme = scheme
config.window_background_opacity = 0.85
config.window_frame = {
    font = wezterm.font("VL NF", {weight = "Bold"}),
    font_size = 18.0,

    active_titlebar_bg = schemes[scheme].background,
    active_titlebar_fg = schemes[scheme].foreground,
    inactive_titlebar_bg = schemes[scheme].background,
    inactive_titlebar_fg = schemes[scheme].foreground,
}
config.colors = {
    scrollbar_thumb = "#cccccc",
    tab_bar = {
        background = schemes[scheme].background,
        active_tab = {
            bg_color = schemes[scheme].background,
            fg_color = schemes[scheme].ansi[4],
        },
        inactive_tab = {
            bg_color = schemes[scheme].background,
            fg_color = schemes[scheme].foreground
        },
        inactive_tab_hover = {
            bg_color = schemes[scheme].background,
            fg_color = schemes[scheme].ansi[5]
        },
        new_tab = {
            bg_color = schemes[scheme].background,
            fg_color = schemes[scheme].foreground
        },
        new_tab_hover = {
            bg_color = schemes[scheme].background,
            fg_color = schemes[scheme].ansi[5]
        }
    }
}

----------------------------------------------------------------------

config.dpi = 96
if wezterm.target_triple:find("darwin") then
    config.dpi = 72
    config.dpi_by_screen = {
        ["Built-in Display"] = 144
    }
end

----------------------------------------------------------------------

wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {
        width = cols,
        height = rows,
    })
end)

wezterm.on("window-resized", function(window, pane)
    local screen = wezterm.gui.screens().active
    local dimensions = window:get_dimensions()
    local x = (screen.width - dimensions.pixel_width) / 2
    local y = (screen.height - dimensions.pixel_height) / 2
    window:gui_window():set_posision(x, y)
end)

----------------------------------------------------------------------

return config


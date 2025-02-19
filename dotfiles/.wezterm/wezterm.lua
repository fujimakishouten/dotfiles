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
local width = 1360
local height = 755
local cols = 148
local rows = 32

----------------------------------------------------------------------

config.automatically_reload_config = true

config.exit_behavior = "CloseOnCleanExit"
config.use_fancy_tab_bar = true
config.use_ime = true
-- config.use_resize_increments = false
config.window_decorations = "RESIZE"

config.initial_cols = cols
config.initial_rows = rows

config.enable_scroll_bar = true
config.scrollback_lines = 20000

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
if string.find(wezterm.target_triple, "darwin") ~= nil then
    config.dpi = 72
    config.dpi_by_screen = {
        ["Built-in Display"] = 144
    }
end

----------------------------------------------------------------------

wezterm.on("gui-startup", function(cmd)
    local x = (wezterm.gui.screens().active.width - width) / 2
    local y = (wezterm.gui.screens().active.height - height) / 2
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {
        width = cols,
        height = rows,
        position = {
            x = x,
            y = y,
            origin = "ActiveScreen"
        }
    })
    window:gui_window():set_position(x, y)
    window:gui_window():set_inner_size(width, height)
end)

----------------------------------------------------------------------

return config


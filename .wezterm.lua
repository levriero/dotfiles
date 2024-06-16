-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Specifies the height of a new window, expressed in character cells.
config.initial_rows = 38

-- Specifies the width of a new window, expressed in character cells.
config.initial_cols = 140

-- Disable the title bar but enable the resizable border
-- NOTE: removing RESIZE from the set of decorations causes problems with resizing and minimizing the window.
config.window_decorations = "RESIZE"

-- Colorscheme
config.color_scheme = "Tokyo Night"

-- If set to true, when there is only a single tab, the tab bar is hidden from the display.
-- If a second tab is created, the tab will be shown.
config.hide_tab_bar_if_only_one_tab = true

-- When set to true (the default), the tab bar is rendered in a native style with proportional fonts.
-- When set to false, the tab bar is rendered using a retro aesthetic using the main terminal font.
config.use_fancy_tab_bar = false

-- This function constructs a lua table that corresponds to the internal FontAttributes struct
-- that is used to select a single named font:
config.font = wezterm.font("JetBrainsMono NF", { weight = "Light" })
config.font_size = 16.0

config.keys = {
	-- Toggles full screen mode for the current window.
	{
		key = "z",
		mods = "SUPER",
		action = wezterm.action.ToggleFullScreen,
	},

	-- Splits the current pane in half horizontally.
	{
		key = "p",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Splits the current pane in half vertically.
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Activate an adjacent pane in the specified direction.
	{
		key = "LeftArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},

	-- Closes the current pane.
	-- If that was the last pane in the tab, closes the tab.
	-- If that was the last tab, closes that window.
	-- If that was the last window, wezterm terminates.
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

-- and finally, return the configuration to wezterm
return config

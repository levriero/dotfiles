-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- Represents a window that is managed by the multiplexer
local mux = wezterm.mux

wezterm.on('gui-attached', function(_)
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()

  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Colorscheme
config.color_scheme = "Tokyo Night"

-- If set to true, when there is only a single tab, the tab bar is hidden from the display.
-- If a second tab is created, the tab will be shown.
config.hide_tab_bar_if_only_one_tab = true

-- Native tab bar options
config.window_frame = {
	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 13.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#1a1b26",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#1a1b26",
}

config.colors = {
	tab_bar = {
		-- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = "#1a1b26",
			fg_color = "white",
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#2a2e40",
			fg_color = "white",
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1a1b26",
			fg_color = "#1a1b26",
		},

		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#2a2e40",
	},
}

-- This function constructs a lua table that corresponds to the internal FontAttributes struct that is used to select a single named font:
config.font = wezterm.font("JetBrains Mono", { weight = "Light" })
config.font_size = 19.0

-- and finally, return the configuration to wezterm
return config

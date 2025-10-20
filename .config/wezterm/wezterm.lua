-- Pull in the wezterm API
local wezterm = require("wezterm")

local merge_table = require("utils.merge_table")
local config = merge_table(require("background"), require("keybinids"))

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 160
config.initial_rows = 90

-- or, changing the font size and color scheme.
config.font_size = 18
--config.color_scheme = 'AdventureTime'
config.color_scheme = "Night Owl (Gogh)"
--config.color_scheme = 'Nova (base16)'

-- tab settings
-- todo: 別ファイル切り出し
config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 16.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
}

-- setting background image
-- todo: 別ファイルへの切り出し

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.1,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- config.window_background_opacity = 1.0 --> default

-- setting shell
config.default_prog = { "/bin/zsh" }

-- setttin launch_menu
config.launch_menu = {
	{ args = { "top" } },
	{ args = { "ls", "-al" } },
}

-- keybinds
-- timeout_milliseconds defaults to 1000 and can be omitted
local act = wezterm.action
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	-- {
	--   key = 'a',
	--   mods = 'LEADER|CTRL',
	--   action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
	-- },
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.PaneSelect,
	},
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
}

-- Finally, return the configuration to wezterm:
return config

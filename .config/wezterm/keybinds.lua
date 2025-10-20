local wezterm = require("wezterm")
local config = wezterm.config_builder()
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

return config

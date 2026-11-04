local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Background opacity
config.window_background_opacity = 0.90

-- Font
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.0

-- Cursor thickness
config.default_cursor_style = "BlinkingBar"

-- Theme
config.color_scheme = "Noctalia"

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 999

config.window_close_confirmation = "NeverPrompt"

config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

-- Custom tab title

wezterm.on("format-tab-title", function(tab)
	return {
		{ Text = "  " .. tab.tab_index + 1 .. "  " },
	}
end)

config.keys = {
	-- New tab
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Close current tab
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},

	-- Select tabs
	{
		key = "1",
		mods = "ALT",
		action = wezterm.action.ActivateTab(0),
	},

	{
		key = "2",
		mods = "ALT",
		action = wezterm.action.ActivateTab(1),
	},

	{
		key = "3",
		mods = "ALT",
		action = wezterm.action.ActivateTab(2),
	},

	{
		key = "4",
		mods = "ALT",
		action = wezterm.action.ActivateTab(3),
	},

	{
		key = "5",
		mods = "ALT",
		action = wezterm.action.ActivateTab(4),
	},

	{
		key = "6",
		mods = "ALT",
		action = wezterm.action.ActivateTab(5),
	},

	{
		key = "7",
		mods = "ALT",
		action = wezterm.action.ActivateTab(6),
	},

	{
		key = "8",
		mods = "ALT",
		action = wezterm.action.ActivateTab(7),
	},

	{
		key = "9",
		mods = "ALT",
		action = wezterm.action.ActivateTab(8),
	},
}

return config

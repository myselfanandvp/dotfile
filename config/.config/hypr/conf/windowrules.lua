--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │        WINDOW RULES        │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

hl.window_rule({
	name = "Yazi",

	match = {
		title = "yazi-float",
	},

	float = true,
	size = "1108 648",
	center = true,
	animation = "popin",
})

hl.window_rule({
	name = "Btop",

	match = {
		title = "btop-float",
	},

	float = true,
	size = "1108 648",
	opacity = 0.9,
	center = true,
	animation = "popin",
})

hl.window_rule({
	name = "Term",

	match = {
		title = "float-term",
	},

	float = true,
	size = "1108 648",
	-- opacity = 0.9,
	center = true,
	animation = "popin",
})

hl.window_rule({
	name = "workfolio",

	match = {
		class = "workfolio",
	},

	float = true,
	center = true,
	size = "500 700",
	animation = "popin",
	workspace = "special:workfolio",
})

hl.window_rule({
	name = "SoundRecorder",

	match = {
		class = "org.gnome.SoundRecorder",
	},

	float = true,
	center = true,
	size = "530 480",
	animation = "popin",
})

hl.window_rule({
	name = "Popsicle",

	match = {
		class = "AppRun.wrapped",
	},

	float = true,
	center = true,
	size = "530 480",
	animation = "popin",
})

hl.window_rule({
	name = "Btrfs-Assistant",

	match = {
		class = "btrfs-assistant",
	},

	float = true,
	center = true,
	size = "1108 648",
	animation = "popin",
})

hl.window_rule({
	name = "Nautilus",

	match = {
		class = "org.gnome.Nautilus",
	},

	float = true,
	center = true,
	size = "1108 648",
	animation = "popin",
	no_blur = true,
	-- opacity = 0.9,
})

hl.window_rule({
	name = "google-meet",

	match = {
		title = "meet.google.com is sharing a window.",
	},

	workspace = "special:google-meet silent",
})

hl.window_rule({
	name = "calculator",

	match = {
		class = "org.gnome.Calculator",
		title = "Calculator",
	},

	animation = "popin",
	size = "385 616",
	float = true,
	center = true,
})

hl.window_rule({
	name = "LocalSend",

	match = {
		class = "localsend",
		title = "LocalSend",
	},

	animation = "popin",
	size = "385 616",
	float = true,
	center = true,
})

hl.window_rule({
	name = "xwayland-video-bridge-fixes",

	match = {
		class = "xwaylandvideobridge",
	},

	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = "1 1",
})

hl.window_rule({
	name = "Zed Editor",

	match = {
		class = "dev.zed.Zed",
	},
	no_blur = false,
	opacity = 0.9,
	float = false,
})

hl.window_rule({
	name = "Tmux",
	match = {
		title = "tmux",
	},
	no_blur = false,
	opacity = 0.9,
	float = false,
})

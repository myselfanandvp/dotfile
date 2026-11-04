--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │        LAYER RULES         │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

hl.layer_rule({
	name = "waybar-blur",
	match = {
		namespace = "waybar",
	},

	blur = true,
})

--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │          NOCTALIA          │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

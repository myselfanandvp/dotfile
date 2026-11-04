--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │           Inputs           │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

hl.config({
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0.5,

		touchpad = {
			natural_scroll = false,
			tap_to_click = true,
			disable_while_typing = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = 0.5,
})

hl.device({
	name = "elan071a:00-04f3:30fd-touchpad",
	sensitivity = 1,
	accel_profile = "flat",
})

hl.permission({
	binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
	type = "screencopy",
	mode = "allow",
})

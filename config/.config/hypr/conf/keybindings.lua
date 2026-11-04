--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │        KEY BINDINGS        │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

local mainMod = "SUPER"
local ipc = "noctalia msg"
local colorPicker = "~/.config/hypr/conf/scripts/hyprpicker.sh"
local terminal = "kitty"
local terminal2 = "wezterm"

local fileManager = "nautilus"

local terminal_fileManager = "yazi"

local menu = "~/.config/hypr/scripts/toggle_rofi.sh"

local browser = "google-chrome-stable"

local mail = "thunderbird"

-- Helper function to change zoom safely
local function adjust_zoom(offset)
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	local new_zoom = math.max(1.0, current + offset) -- Prevent zooming out past 1.0
	hl.config({ cursor = { zoom_factor = new_zoom } })
end
-- Bind zoom to MainMod + ALT + Mouse Wheel
hl.bind(mainMod .. " + ALT + mouse_down", function()
	adjust_zoom(0.8)
end)
hl.bind(mainMod .. " + ALT + mouse_up", function()
	adjust_zoom(-0.8)
end)
hl.bind(mainMod .. " + ALT + mouse:272", function()
	hl.config({ cursor = { zoom_factor = 1.0 } })
end)

--    ╭────────────────────────────╮
--    │        APPLICATIONS        │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/Dotfiles/config/.config/hypr/conf/scripts/hyprmag.sh"))

hl.bind("ALT + RETURN", hl.dsp.exec_cmd(terminal2))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(colorPicker))

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(fileManager))

hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("code"))

hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(terminal .. " -e " .. terminal_fileManager))

hl.bind(mainMod .. " + CTRL + M", hl.dsp.exec_cmd(mail))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/conf/scripts/kitty_toggle.sh"))

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/conf/scripts/btop_toggle.sh"))

hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("google-chrome-stable --incognito"))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/.config/hypr/conf/scripts/yazi.sh"))

--    ╭────────────────────────────╮
--    │     WINDOW MANAGEMENT      │
--    ╰────────────────────────────╯
--

hl.bind("SUPER + A", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))

hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 0 }))

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

--    ╭────────────────────────────╮
--    │       FOCUS MOVEMENT       │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))

hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

--    ╭────────────────────────────╮
--    │        WINDOW SWAP         │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))

hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT+ h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))

--    ╭────────────────────────────╮
--    │       WINDOW RESIZE        │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -20 0"))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 20 0"))

hl.bind(mainMod .. " + SHIFT + up", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -20"))

hl.bind(mainMod .. " + SHIFT + down", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 20"))

--    ╭────────────────────────────╮
--    │         WORKSPACES         │
--    ╰────────────────────────────╯

for i = 1, 10 do
	local key = i % 10

	hl.bind(mainMod .. "+" .. key, hl.dsp.focus({ workspace = i }))

	hl.bind("CTRL +" .. key, hl.dsp.window.move({ workspace = i }))
end

--    ╭────────────────────────────╮
--    │     SPECIAL WORKSPACE      │
--    ╰────────────────────────────╯

hl.bind("SUPER + D", function()
	hl.plugin.hyprexpo.expo("toggle")
end)

hl.bind(mainMod .. "+ALT + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("ALT + W", hl.dsp.workspace.toggle_special("workfolio"))

hl.bind("ALT + M", hl.dsp.workspace.toggle_special("spotify"))

--    ╭────────────────────────────╮
--    │         SCROLL WS          │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

--    ╭────────────────────────────╮
--    │        MOUSE BINDS         │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))

--    ╭────────────────────────────╮
--    │        SCREENSHOTS         │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots/"))

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))

--    ╭────────────────────────────╮
--    │         CLIPBOARD          │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("cliphist wipe"))

--    ╭────────────────────────────╮
--    │         MEDIA KEYS         │
--    ╰────────────────────────────╯

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && swayosd-client --output-volume raise"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && swayosd-client --brightness raise"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && swayosd-client --brightness lower"),
	{ locked = true, repeating = true }
)

--    ╭────────────────────────────╮
--    │       MEDIA CONTROL        │
--    ╰────────────────────────────╯

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--    ╭────────────────────────────╮
--    │          GROUPING          │
--    ╰────────────────────────────╯

hl.bind(mainMod .. " + G", hl.dsp.group.toggle())

hl.bind(mainMod .. " + CTRL + G", hl.dsp.window.move({ out_of_group = true }))

hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ into_group = "r" }))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ into_group = "l" }))

hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ into_group = "d" }))

hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ into_group = "u" }))

hl.bind("ALT + TAB", hl.dsp.group.next())

hl.bind("ALT + SHIFT + TAB", hl.dsp.group.prev())

--    ╭────────────────────────────╮
--    │        NOCTALIA IPC        │
--    ╰────────────────────────────╯

--  ─────────── Core binds ───────────

hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher"))
hl.bind(mainMod .. "+N", hl.dsp.exec_cmd(ipc .. " panel-toggle noctalia/notes:panel"))
hl.bind(mainMod .. "+S", hl.dsp.exec_cmd(ipc .. " panel-toggle control-center"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. " settings-toggle"))
hl.bind(mainMod .. "+period", hl.dsp.exec_cmd(ipc .. " panel-toggle launcher /emo"))
hl.bind(mainMod .. "+X", hl.dsp.exec_cmd(ipc .. " panel-toggle session"))
hl.bind(mainMod .. "+W", hl.dsp.exec_cmd(ipc .. " panel-toggle wallpaper"))
hl.bind(mainMod .. " +ALT+L", hl.dsp.exec_cmd(ipc .. " session lock"))

--  ─────────── Media keys ───────────

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness-down"))

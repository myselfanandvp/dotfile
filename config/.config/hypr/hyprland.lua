--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │    Main Hyprland Config    │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

--    ╭────────────────────────────╮
--    │     Requirement Files      │
--    ╰────────────────────────────╯

require("conf.monitors")
require("conf.autostart")
require("conf.input")
require("conf.appearance")
require("conf.keybindings")
require("conf.workspaces")
require("conf.windowrules")
require("conf.layerrules")

-- For Noctalia Color templates
require("noctalia").apply_theme()

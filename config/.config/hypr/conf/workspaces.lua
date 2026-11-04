--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │         WORKSPACES         │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

hl.workspace_rule({
	workspace = "1",
	persistent = true,
})

--    ╭──────────────────────────────────────╮
--    │    ╭────────────────────────────╮    │
--    │    │     SPECIAL WORKSPACES     │    │
--    │    ╰────────────────────────────╯    │
--    ╰──────────────────────────────────────╯

hl.workspace_rule({
	workspace = "special:workfolio",
	persistent = true,
})
hl.workspace_rule({
	workspace = "special:spotify",
	persistent = true,
})

hl.workspace_rule({
	workspace = "special:qprompt",
	persistent = true,
})

hl.workspace_rule({ workspace = "1", layout_opts = { direction = "right" } })

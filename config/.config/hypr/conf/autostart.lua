hl.on("hyprland.start", function()
	--    ╭────────────────────────────╮
	--    │        Noctalia shell        │
	--    ╰────────────────────────────╯

	hl.exec_cmd("workfolio")
	hl.exec_cmd("distrobox enter --name ubuntubox -- workfolio")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("flatpak run com.github.wwmm.easyeffects")
	-- Clean up portals completely first
	hl.exec_cmd("killall -9 xdg-desktop-portal-hyprland")
	hl.exec_cmd("killall -9 xdg-desktop-portal-gtk")
	-- hl.exec_cmd("killall -9 xdg-desktop-portal")

	-- Launch the Hyprland portal backend, then the main portal service
	hl.exec_cmd("sleep 1 && /usr/libexec/xdg-desktop-portal-hyprland &")
	hl.exec_cmd("sleep 2 && /usr/libexec/xdg-desktop-portal &")

	-- Update D-Bus environment variables so apps know Hyprland is active
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland QT_QPA_PLATFORMTHEME"
	)

	--    ╭────────────────────────────╮
	--    │            Polkit          │
	--    ╰────────────────────────────╯
	-- hl.exec_cmd("lxpolkit")
end)

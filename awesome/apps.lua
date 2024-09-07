-- Themes
local rofi_themes   = {
    "Arc-Dark",        -- 1
    'arthur',          -- 2
    'Monokai',         -- 3
    'fancy',           -- 4
    'rounded-nord-dark', -- 5
    '.awesome/rofi.rasi'
}
local rofi_theme    =  rofi_themes[5]

return {
	--- Default Applications
	default = {
		--- Default terminal emulator
        terminal = "x-terminal-emulator",
		--- Default text editor
		editor = os.getenv("EDITOR") or "vim",
		--- Default code editor
		code_editor = "code",
		--- Default web browser
		web_browser = "firefox",
		--- Default file manager
		file_manager = "nautilus",
		--- Default network manager
		network_manager = "wezterm start nmtui",
		--- Default bluetooth manager
		bluetooth_manager = "blueman-manager",
		--- Default power manager
		power_manager = "xfce4-power-manager",
		--- Default rofi global menu
		app_launcher = string.format("rofi -no-lazy-grab -show run -theme %s", rofi_theme),
        win_launcher = string.format("rofi -no-lazy-grab -show window -theme %s", rofi_theme),
	}
}

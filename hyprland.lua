hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "auto",
	scale = 1.0,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1.0,
	mirror = "eDP-1",
})

local mainMod = "SUPER"

local HOME = os.getenv("HOME")
local hyprDir = HOME .. "/.config/hypr"
local scriptsDir = HOME .. "/.config/hypr/scripts"

local term = "kitty"
local alt_term = "alacritty"
local browser = "firefox"
local alt_browser = "chromium"
local files = "thunar"
local menu = scriptsDir .. "/menut"
local fullmenu = scriptsDir .. "/fullmenut"
local volume = scriptsDir .. "/volume"
local brightness = scriptsDir .. "/real-brightness"
local screenshot = scriptsDir .. "/screenshot"
local wallpaper = scriptsDir .. "/changewallpaper"

hl.env("GTK_THEME", "Tokyonight-Dark-Storm")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern_classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern_classic")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd(scriptsDir .. "/startup")
	hl.exec_cmd(scriptsDir .. "/portal")
	hl.exec_cmd("/usr/bin/awww-daemon")
	hl.exec_cmd(wallpaper)
end)

local colors = dofile(HOME .. "/.cache/wal/colors.lua")

hl.config({
	input = {
		kb_layout = "us,fr,ara",
		kb_variant = ",,azerty",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		repeat_rate = 40,
		repeat_delay = 200,

		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
			tap_to_click = true,
			drag_lock = 0,
			disable_while_typing = true,
		},
	},
})

hl.config({
	misc = {
		disable_hyprland_logo = true,
		mouse_move_enables_dpms = true,
		disable_splash_rendering = true,
	},
})

hl.config({
	binds = {
		workspace_back_and_forth = true,
	},
})

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 6,

		border_size = 3,

		col = {
			active_border = {
				colors = { colors.color6, colors.color3 },
				angle = 80,
			},
			inactive_border = colors.color0,
		},

		resize_on_border = false,
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 3,
		rounding_power = 4,

		active_opacity = 1.0,
		inactive_opacity = 0.8,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		motion_blur = {
			enabled = true,
			samples = 5,
		},

		blur = {
			enabled = true,

			-- normal blur:
			size = 3,
			passes = 1,

			-- transluscent blur:
			-- size = 8
			-- passes = 2

			-- size = 5,
			-- passes =2,
			vibrancy = 0.1696,

			-- variant = "glass",
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
		mfact = 0.60,
	},

	scrolling = {
		fullscreen_on_one_column = false,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	match = {
		class = "^pavucontrol$",
		title = "^Volume Control$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^(firefox)$",
		title = "^(Picture-in-Picture)$",
	},
	float = true,
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(fullmenu))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scriptsDir .. "/wallpicker"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind("CTRL + ALT + Return", hl.dsp.exec_cmd(alt_term))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("st"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pavucontrol"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(alt_browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("logseq"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("obidian"))
hl.bind("ALT + N", hl.dsp.exec_cmd(wallpaper))
hl.bind(
	mainMod .. " + Escape",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("wlogout"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volume .. " --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volume .. " --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volume .. " --toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(volume .. " --toggle-mic"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightness .. " --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightness .. " --dec"), { locked = true, repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + U", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("Print", hl.dsp.exec_cmd(screenshot .. " --now"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --in10"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(screenshot .. " --win"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --area"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot .. " --in5"))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i }, { follow = "true" }))
end

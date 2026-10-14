-- Migrated from the legacy hyprland.conf format to the Hyprland 0.55+ Lua config.
-- The old hyprland.conf is intentionally kept as a fallback/reference.
--
-- Reading guide:
-- 1. Values are kept as close to the old config as possible.
-- 2. Where the old config had duplicate settings, this file keeps the final effective one.
-- 3. One known behavior change: dwindle.pseudotile is NOT a valid static config key on 0.55.4,
--    so pseudotiling is now controlled by the keybind only (Alt+P), not forced globally at startup.

------------------
---- MONITORS ----
------------------

hl.monitor({
	-- Built-in laptop display: keep preferred mode, auto placement, and your old 1.67 scale.
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1.67,
})

hl.monitor({
	-- External HDMI display: keep preferred mode, auto placement, automatic scale, and no rotation.
	output = "HDMI-A-1",
	mode = "preferred",
	position = "auto",
	scale = "auto",
	transform = 0,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local mainMod = "ALT"

-- These locals replace old $variables from hyprlang:
-- $terminal / $fileManager / $menu / $mainMod

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	-- Keep startup order the same as the old config.
	-- waybar: panel
	-- fcitx5: input method daemon
	-- hyprpaper: wallpaper daemon, still reads ~/.config/hypr/hyprpaper.conf
	hl.exec_cmd("swaync")
	hl.exec_cmd("waybar")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("hyprpaper")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Environment variables exported into the Hyprland session.
-- Note: the old config set XCURSOR_SIZE twice (24, then 32).
-- In practice the later line wins, so we keep only the final effective value here.
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "32")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("XMODIFIERS", "@im=fcitx")
-- Keep the fcitx GTK module available for GTK2 and XWayland applications.
-- Firefox opts out in its user-local desktop entry so it can use Wayland text-input.
-- hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		-- Window gaps and border behavior.
		gaps_in = 2,
		gaps_out = 10,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		-- Rounded corners, opacity, shadows, and blur.
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		-- Old config used the joke value: enabled = yes, please :)
		-- Lua config requires a real boolean.
		enabled = true,
	},
})

-- Keep your old bezier curves one-for-one.
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Keep your old animation tree and speeds one-for-one.
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
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
		-- preserve_split exists on 0.55.4 and passed config verification.
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		-- Keyboard layout and pointer behavior.
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
	xwayland = {
		-- Keep your old XWayland scaling workaround.
		force_zero_scaling = true,
	},
})

hl.gesture({
	-- Old config: gesture = 3, horizontal, workspace
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	-- Preserved example per-device override from the old config.
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Media keys.
-- The old config had duplicate volume/brightness binds in two places.
-- This file keeps the later, more complete set as the source of truth.
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd("hyprlock"))

-- Core app/window binds.
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(
	mainMod .. " + SHIFT + R",
	hl.dsp.exec_cmd([[command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit]])
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
-- Alt+P still toggles pseudotile for the active window.
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- Dwindle layout split toggle.
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
-- Swap the two halves of the current Dwindle split.
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.layout("swapsplit"))
-- Old `fullscreen, 0` maps most closely to a fullscreen toggle in Lua.
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- Old togglefloating.
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
-- Old killactive.
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

-- Focus movement with arrows.
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Focus movement with Vim-style keys.
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Swap the active tiled window with the neighboring window.
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
-- Manual resizing of the active tiled window.
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

-- Region screenshot to clipboard / swappy.
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

-- Workspace switching and moving active window to a workspace.
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratch workspace.
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:magic" }))

-- Keep your original scroll direction semantics.
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- Mouse move/resize binds.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media playback keys.
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ignore maximize requests from clients.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Preserve your XWayland drag workaround.
hl.window_rule({
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

-- Preserve placement/float behavior for hyprland-run.
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

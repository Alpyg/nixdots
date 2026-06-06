local hs = require("hyprsplit")
hs.config({ num_workspaces = 10 })

local mod      = "SUPER"
local terminal = "kitty"


hl.monitor({
  output   = "DP-1",
  mode     = "1920x1080@60",
  position = "0x0",
  scale    = 1,
})

hl.monitor({
  output   = "HDMI-A-1",
  mode     = "1920x1080@60",
  position = "1920x0",
  scale    = 1,
})

hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = 1,
})


hl.on("hyprland.start", function()
  hl.exec_cmd("steam")
  hl.exec_cmd("discord")
  hl.exec_cmd("dunst")
  hl.exec_cmd("clipse -listen")
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)


hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("___GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__NV_DISABLE_EXPLICIT_SYNC", "1")
hl.env("XDG_MENU_PREFIX", "arch-")


hl.config({
  general = {
    gaps_in       = 4,
    gaps_out      = 8,
    border_size   = 2,
    layout        = "dwindle",
    allow_tearing = true,
    col           = {
      active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
  },

  decoration = {
    rounding         = 8,
    rounding_power   = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  input = {
    kb_layout    = "us",
    follow_mouse = 0,
  },
})


hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

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


-- Apps
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + D", hl.dsp.exec_cmd("wofi --show run"))

-- Window management
hl.bind(mod .. " + X", hl.dsp.window.close())
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Focus movement (vim keys)
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Window swapping (vim keys)
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-- Mouse binds
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ -5%"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ +5% -l 1"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Media
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot --clipboard-only -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot --clipboard-only -m window"))

-- Clipboard manager
hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd(terminal .. " --class clipse -e clipse"))

-- Workspaces (split-monitor-workspaces plugin)
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hs.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. i, hs.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mod .. " + 0", hs.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + 0", hs.dsp.window.move({ workspace = 10, follow = false }))

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha (Gogh)"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.5

return config

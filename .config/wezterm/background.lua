local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.background = {
  {
    source = {
      File = "~/dotfiles/wezterm/images/face_tunnel.png",
    },
    hsb = {
      -- Darken the background image by reducing it to 1/3rd
      brightness = 0.1,

      -- You can adjust the hue by scaling its value.
      -- a multiplier of 1.0 leaves the value unchanged.
      hue = 1.0,

      -- You can adjust the saturation also.
      saturation = 1.0,
    },
  },
}

return config

{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "monokai_pro";

    settings = {
      window = {
        padding = { x = 8; y = 8; };
        opacity = 0.95;
      };
      font = {
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
        size = 16;
      };
    };
  };
}

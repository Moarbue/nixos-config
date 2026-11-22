{ config, ... }:

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
        normal = { family = config.my.font.family; style = "Regular"; };
        size = config.my.font.size;
      };
    };
  };
}

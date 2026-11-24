# Small set of knobs that differ per machine. Hosts set them in
# hosts/<name>/home.nix; the shared modules read them.
{ config, lib, ... }:

{
  options.my = {
    font = {
      family = lib.mkOption {
        type = lib.types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Monospace/UI font used by terminal and shell.";
      };
      size = lib.mkOption {
        type = lib.types.number;
        default = 14;
        description = "Terminal font size.";
      };
      editorSize = lib.mkOption {
        type = lib.types.number;
        default = config.my.font.size + 4;
        description = "Font size in the editor (Zed). Defaults to the terminal size + 2.";
      };
    };

    niri = {
      touchpad = lib.mkEnableOption "touchpad and trackpoint input in niri";
      touchpadSpeed = lib.mkOption {
        type = lib.types.numbers.between (-1) 1;
        default = 0.0;
        description = "libinput acceleration speed of the touchpad (-1 slowest, 1 fastest).";
      };
      trackpointSpeed = lib.mkOption {
        type = lib.types.numbers.between (-1) 1;
        default = 0.0;
        description = "libinput acceleration speed of the trackpoint (-1 slowest, 1 fastest).";
      };
      touchpadScrollFactor = lib.mkOption {
        type = lib.types.numbers.positive;
        default = 1.0;
        description = "Touchpad scroll speed multiplier (1.0 = default, lower = slower).";
      };
      outputs = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Raw KDL `output \"…\" { … }` blocks for this machine.";
      };
    };
  };
}

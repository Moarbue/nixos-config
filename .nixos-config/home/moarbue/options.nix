# Small set of knobs that differ per machine. Hosts set them in
# hosts/<name>/home.nix; the shared modules read them.
{ lib, ... }:

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
        default = 12;
        description = "Terminal font size.";
      };
    };

    niri = {
      touchpad = lib.mkEnableOption "touchpad and trackpoint input in niri";
      outputs = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Raw KDL `output \"…\" { … }` blocks for this machine.";
      };
    };
  };
}

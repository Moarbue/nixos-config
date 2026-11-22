# Steam & friends. Vulkan/GL setup comes from hardware.graphics (desktop.nix)
# and the GPU driver module of the host — nothing vendor-specific here.
{ pkgs, ... }:

{
  programs.steam.enable = true; # also enables 32-bit graphics
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
  ];
}

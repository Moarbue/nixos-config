# ThinkPad X13 Gen 3 — assumes the INTEL variant (12th gen).
# If yours is the AMD variant: drop thermald/intel-media-driver below and
# look at hardware.amdgpu / amd_pstate instead.
{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/laptop.nix
  ];

  networking.hostName = "moarlt";
  system.stateVersion = "26.11";

  services.thermald.enable = true;
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ]; # VA-API
}

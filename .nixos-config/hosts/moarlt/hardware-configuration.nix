# PLACEHOLDER — replace this file with the output of
#   nixos-generate-config --show-hardware-config
# run on the ThinkPad. Until then `nixos-rebuild` fails on the missing
# root filesystem, which is intended.
{ lib, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  services.openssh.enable = false;
}

{ config, lib, pkgs, ... }:

{
  users.users.moarbue = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" ];
  };

  programs.zsh.enable = true;
}

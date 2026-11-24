{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.moarbue = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
    ];
  };
}

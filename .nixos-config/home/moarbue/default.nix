{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ./options.nix
    ./niri.nix
    ./programs/alacritty.nix
    ./programs/git.nix
    ./programs/librewolf.nix
    ./programs/noctalia.nix
    ./programs/shell.nix
    ./programs/vim.nix
  ];

  home = {
    username = "moarbue";
    homeDirectory = "/home/moarbue";
    stateVersion = "26.11";

    pointerCursor = {
      enable = true;
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    packages = with pkgs; [
      ungoogled-chromium
      tutanota-desktop
      mpv
      vesktop
      signal-desktop
      karere
      zed-editor
    ];
  };

  programs.home-manager.enable = true;

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };
}

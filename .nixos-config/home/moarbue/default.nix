{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ./options.nix
    ./mimeapps.nix
    ./niri.nix
    ./programs/alacritty.nix
    ./programs/git.nix
    ./programs/librewolf.nix
    ./programs/noctalia.nix
    ./programs/opencode.nix
    ./programs/shell.nix
    ./programs/ssh.nix
    ./programs/viewers.nix
    ./programs/vim.nix
    ./programs/yazi.nix
    ./programs/zed.nix
    ./theme.nix
    ./xdg.nix
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
      vesktop
      signal-desktop
      karere
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

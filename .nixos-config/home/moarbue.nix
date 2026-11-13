{ config, pkgs, inputs, ... }:

{
  home.username = "moarbue";
  home.homeDirectory = "/home/moarbue";
  home.stateVersion = "26.11";

  imports = [
    inputs.noctalia.homeModules.default
    ./modules/alacritty.nix
    ./modules/librewolf.nix
    ./modules/noctalia.nix
    ./modules/vim.nix
  ];

  programs.home-manager.enable = true;

  home.pointerCursor = {
    enable = true;
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons";
      tree = "eza --tree --icons";
      grep = "rg";
      find = "fd";
      cat = "bat";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "moarbue";
        email = "83272310+Moarbue@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    ungoogled-chromium
    tutanota-desktop
    mpv
    vesktop signal-desktop karere
    zed-editor
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
  };

  xdg.configFile."niri/config.kdl".source = ./modules/niri.kdl;
}

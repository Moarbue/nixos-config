# Wayland desktop: niri + greetd/tuigreet. Shared by desktop and laptop.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.niri.enable = true;

  services.displayManager.regreet = {
    enable = true; # also enables greetd, runs regreet inside cage

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    extraCss = ''
      picture {
        background-image: url("file://${./assets/greeter.jpg}");
        background-size: cover;
        background-position: center;
      }
    '';

    settings = {
      GTK.application_prefer_dark_theme = true;
      appearance.greeting_msg = "Welcome back";
      widget.clock = {
        format = "%A, %-d. %B %Y - %H:%M";
        resolution = "1s";
      };
    };
  };

  # greetd doesn't forward the service environment to the greeter, so the
  # layout is set in the command. cage (wlroots) reads XKB_DEFAULT_*.
  # Same command the regreet module generates, plus the two variables.
  services.greetd.settings.default_session.command = lib.mkForce (
    lib.concatStringsSep " " (
      [
        "${pkgs.coreutils}/bin/env"
        "XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}"
        "XKB_DEFAULT_VARIANT=${config.services.xserver.xkb.variant}"
        (lib.getExe' pkgs.dbus "dbus-run-session")
        (lib.getExe pkgs.cage)
      ]
      ++ config.services.displayManager.regreet.cageArgs
      ++ [
        "--"
        (lib.getExe config.services.displayManager.regreet.package)
      ]
    )
  );

  hardware.graphics.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    dejavu_fonts
    liberation_ttf
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  security.polkit.enable = true;

  # Electron/Chromium apps use native Wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    xwayland-satellite # niri starts it on demand when it is in PATH
    wl-clipboard
    adwaita-icon-theme
    hicolor-icon-theme
    gnome-themes-extra
  ];
}

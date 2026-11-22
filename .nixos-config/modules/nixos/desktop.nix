# Wayland desktop: niri + greetd/tuigreet. Shared by desktop and laptop.
{ config, lib, pkgs, ... }:

{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true; # sets the tty/journal service options tuigreet needs
    settings.default_session = {
      user = "greeter";
      command = lib.escapeShellArgs [
        (lib.getExe pkgs.tuigreet)
        "--time"
        "--time-format" "%A, %-d. %B %Y - %H:%M:%S"
        "--remember"
        "--asterisks"
        "--greeting" "Welcome back"
        "--theme" "border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red"
        "--cmd" (lib.getExe' config.programs.niri.package "niri-session")
      ];
    };
  };

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

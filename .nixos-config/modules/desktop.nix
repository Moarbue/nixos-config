{ config, lib, pkgs, ... }:

{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --time-format '%A, %-d. %B %Y - %H:%M:%S' --remember --asterisks --greeting 'Welcome back' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --background matrix --cmd ${config.programs.niri.package}/bin/niri-session";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji
    dejavu_fonts liberation_ttf font-awesome
    nerd-fonts.jetbrains-mono nerd-fonts.fira-code
  ];
  fonts.fontconfig.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    xwayland-satellite
    wl-clipboard grim slurp
    adwaita-icon-theme hicolor-icon-theme gnome-themes-extra
  ];
}

{ config, lib, pkgs, ... }:

{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --asterisks --cmd ${config.programs.niri.package}/bin/niri-session";
        user = "greeter";
      };
    };
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

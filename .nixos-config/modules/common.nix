{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
  };
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
    "it_IT.UTF-8/UTF-8"
  ];

  console.keyMap = "de-latin1-nodeadkeys";
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  environment.systemPackages = with pkgs; [
    git curl wget htop btop unzip zip
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

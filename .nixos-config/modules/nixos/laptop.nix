# Things only a laptop needs.
{ ... }:

{
  # Use power-profiles-daemon *or* TLP, never both.
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true; # battery info for the shell

  services.fwupd.enable = true; # Lenovo ships firmware updates via LVFS

  # Backlight control for the brightness keys.
  users.users.moarbue.extraGroups = [ "video" ];

  # Fingerprint reader (check `lsusb` / ThinkPad spec first):
  # services.fprintd.enable = true;
}

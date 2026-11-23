# Things only a laptop needs.
{ config, ... }:

{
  # Use power-profiles-daemon *or* TLP, never both.
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true; # battery info for the shell

  services.fwupd.enable = true; # Lenovo ships firmware updates via LVFS

  # Backlight control for the brightness keys.
  users.users.moarbue.extraGroups = [ "video" ];

  # Fingerprint reader: Goodix 27c6:6594 (MoC), supported by upstream libfprint.
  # This turns on fingerprint auth for every PAM service (sudo, polkit, lock...).
  services.fprintd.enable = true;

  # Greeter stays password-only: pam_fprintd would block the password prompt
  # until the scan times out, and the first login after boot needs the password
  # anyway (LUKS, keyring later).
  security.pam.services.greetd.fprintAuth = false;

  # Lock screen (noctalia) authenticates through the `login` PAM service.
  # Password first, fingerprint after an empty Enter; otherwise a typed
  # password waits for the fingerprint timeout.
  security.pam.services.login.rules.auth.fprintd.order =
  config.security.pam.services.login.rules.auth.unix.order + 10;
}

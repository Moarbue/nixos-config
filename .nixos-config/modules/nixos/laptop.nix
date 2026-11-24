# Things only a laptop needs.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Use power-profiles-daemon *or* TLP, never both.
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true; # battery info for the shell

  systemd.services.thinkpad-battery-thresholds = {
    description = "Set ThinkPad battery charge thresholds";
    wantedBy = [
      "multi-user.target"
      "post-resume.target"
    ];
    after = [ "post-resume.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "set-bat-thresholds" ''
        BAT=/sys/class/power_supply/BAT0
        if [ -d "$BAT" ]; then
          echo 0 > "$BAT/charge_control_start_threshold"
          echo 80 > "$BAT/charge_control_end_threshold"
          echo 75 > "$BAT/charge_control_start_threshold"
        fi
      '';
    };
  };

  services.fwupd.enable = true; # Lenovo ships firmware updates via LVFS

  # Backlight control for the brightness keys
  users.users.moarbue.extraGroups = [
    "video"
  ];

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

  programs.captive-browser = {
    enable = true;
    interface = "wlp1s0";
    bindInterface = false;
    browser =
      "env HOME=/home/moarbue XDG_CONFIG_HOME=/home/moarbue/.config "
      + lib.concatStringsSep " " [
        (lib.getExe pkgs.chromium)
        "--crash-dumps-dir=/tmp/chromium-captive-crashes"
        "--disable-features=HttpsFirstModeIncognito,HttpsFirstModeIncognitoNewSettings,HttpsUpgrades,HttpsFirstBalancedModeAutoEnable"
        "--class=captive-browser"
        "--test-type"
        "--user-data-dir=/home/moarbue/.local/share/chromium-captive"
        ''--proxy-server="socks5://$PROXY"''
        ''--host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE localhost"''
        "--no-first-run"
        "--new-window"
        "--incognito"
        "--no-default-browser-check"
        "http://neverssl.com"
      ];
  };

  systemd.tmpfiles.rules = [
    "d /tmp/chromium-captive-crashes 0700 moarbue users -"
  ];

  # NM probes URL. Not 204/expected body → state PORTAL.
  networking.networkmanager.settings.connectivity = {
    uri = "http://detectportal.firefox.com/success.txt";
    response = "success";
    interval = 300;
  };

  # Notify when portal detected. Dispatcher run as root → hop into user session.
  networking.networkmanager.dispatcherScripts = [
    {
      type = "basic";
      source = pkgs.writeShellScript "captive-notify" ''
        [ "$2" = "connectivity-change" ] || exit 0
        [ "$CONNECTIVITY_STATE" = "PORTAL" ] || exit 0
        ${pkgs.util-linux}/bin/runuser -u moarbue -- \
          env DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
          ${pkgs.libnotify}/bin/notify-send -u critical \
          "Wi-Fi login required" "Press Mod+Shift+C to open captive portal"
      '';
    }
  ];
}

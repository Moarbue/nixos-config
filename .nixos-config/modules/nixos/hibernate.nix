# Hibernation with a hybrid swap setup (laptop):
#   - zram (base.nix, priority 5)   → fast, used for everyday memory pressure
#   - Btrfs swapfile in @swap       → lower priority, used for the hibernation image
# Lid close on battery does suspend-then-hibernate: suspend first, hibernate after a delay
# so an unattended laptop in a bag doesn't drain the battery overnight.
#
# The swapfile lives in /swap/swapfile; its physical offset
# (my.hibernate.resumeOffset) is needed so the kernel can find it.
{ config, lib, ... }:

let
  cfg = config.my.hibernate;
in
{
  options.my.hibernate.resumeOffset = lib.mkOption {
    type = lib.types.nullOr lib.types.ints.unsigned;
    default = null;
    description = ''
      Physical offset of /swap/swapfile, from
      `btrfs inspect-internal map-swapfile -r /swap/swapfile`.
    '';
  };

  config = {
    assertions = [
      {
        assertion = cfg.resumeOffset != null;
        message = "my.hibernate.resumeOffset is not set; get it with `btrfs inspect-internal map-swapfile -r /swap/swapfile`.";
      }
    ];

    # Dedicated subvolume: no snapshots, so the swapfile can stay active.
    # Mount options must match the other subvolumes (same filesystem);
    # the swapfile itself is created NOCOW and is never compressed.
    fileSystems."/swap".options = [ "compress=zstd" "noatime" ];

    swapDevices = [ { device = "/swap/swapfile"; } ];

    boot.resumeDevice = "/dev/mapper/cryptroot";
    boot.kernelParams = lib.optional (cfg.resumeOffset != null) "resume_offset=${toString cfg.resumeOffset}";

    # Battery: lock (noctalia does that on sleep) + suspend-then-hibernate.
    # On AC or docked the lid does nothing.
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };
    systemd.sleep.settings.Sleep.HibernateDelaySec = "1h";
  };
}

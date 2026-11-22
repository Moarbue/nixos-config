# Btrfs layout shared by both machines: subvolumes @root, @home, @nix, @log
# on a single filesystem (mounted at /, /home, /nix, /var/log).
{ lib, ... }:

{
  # All subvolumes share one filesystem, so their mount options must match.
  # (Merged with the subvol= options from hardware-configuration.nix.)
  fileSystems = lib.genAttrs [ "/" "/home" "/nix" "/var/log" ] (_: {
    options = [ "compress=zstd" "noatime" ];
  });

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ]; # one filesystem → scrub once
  };

  services.fstrim.enable = true;
}

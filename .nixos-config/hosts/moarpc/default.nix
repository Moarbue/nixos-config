{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/gaming.nix
  ];

  networking.hostName = "moarpc";
  system.stateVersion = "26.11";

  powerManagement.cpuFreqGovernor = "performance";

  # ── Btrfs ──────────────────────────────────────────────────────────
  # All four subvolumes live on one filesystem, so mount options must match.
  # (They are merged with the ones in hardware-configuration.nix.)
  fileSystems = lib.genAttrs [ "/" "/home" "/nix" "/var/log" ] (_: {
    options = [ "compress=zstd" "noatime" ];
  });

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ]; # one filesystem → scrub once
  };
}

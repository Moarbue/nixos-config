{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/nixos/btrfs.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/snapshots.nix
  ];

  networking.hostName = "moarpc";
  system.stateVersion = "26.11";

  powerManagement.cpuFreqGovernor = "performance";

  systemd.tmpfiles.rules = [
    "d /data/steam 0755 moarbue users -"
    "v /home/moarbue/games 0755 moarbue users -"
  ];

  # Defined in hardware-configuration.nix; this only adds an option.
  fileSystems."/data".options = [
    "noatime"
    "nofail"
  ];
}

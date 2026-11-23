# ThinkPad X13 Gen 3 (AMD Ryzen 5 PRO 6000 series, Radeon 680M iGPU).
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/btrfs.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/hibernate.nix
    ../../modules/nixos/snapshots.nix
  ];

  networking.hostName = "moarlt";
  system.stateVersion = "26.11";

  # LUKS container created during installation (see INSTALL.md). The device
  # itself comes from hardware-configuration.nix; this only adds tuning. The
  # name must match the mapper name used at install time ("cryptroot").
  boot.initrd.luks.devices."cryptroot" = {
    allowDiscards = true;
    bypassWorkqueues = true;
  };

  # Offset of /swap/swapfile.
  my.hibernate.resumeOffset = 533760;

  # Nothing GPU-specific needed: amdgpu is in the kernel, and Mesa (pulled in
  # by hardware.graphics) already provides OpenGL, Vulkan (RADV) and VA-API.
  # The generated hardware-configuration.nix loads kvm-amd and the microcode.
  # power-profiles-daemon (laptop.nix) drives amd-pstate's energy preference.
}

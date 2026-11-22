# GTX 970 (Maxwell): the 580 branch is the last proprietary driver that
# supports it, so it has to be the legacy package.
{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ]; # needed for Wayland as well

  hardware.nvidia = {
    # modesetting.enable already adds nvidia-drm.modeset=1 and fbdev=1.
    modesetting.enable = true;
    # Also adds NVreg_PreserveVideoMemoryAllocations + suspend/resume units.
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  nixpkgs.config.nvidia.acceptLicense = true;
}

# Shared by every machine.
{ inputs, pkgs, ... }:

{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.nur.overlays.default ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    # Make `nix shell nixpkgs#foo` and `nix flake init -t self#<tpl>` resolve to this flake.
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      self.flake = inputs.self;
    };
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    channel.enable = false;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10; # keep /boot from filling up
    };
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;
  boot.tmp.cleanOnBoot = true;

  # Lets prebuilt (non-Nix) binaries run, e.g. Zed's downloaded language servers.
  programs.nix-ld.enable = true;

  # ── Locale / keyboard ──────────────────────────────────────────────
  time.timeZone = "Europe/Rome";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "it_IT.UTF-8/UTF-8"
    ];
  };

  console.keyMap = "de-latin1-nodeadkeys";
  # Single source of truth for the graphical layout: niri reads it via
  # `osConfig` in home/moarbue/niri.nix.
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # ── Networking ─────────────────────────────────────────────────────
  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
  };

  # Pin GitHub's SSH host key (from https://api.github.com/meta) so the first
  # connection doesn't depend on trust-on-first-use.
  programs.ssh.knownHosts."github.com".publicKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

  # ── Audio / Bluetooth / removable media ────────────────────────────
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

  services.udisks2.enable = true; # used by udiskie (home-manager)

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    htop
    btop
    unzip
    zip
    vim
    usbutils
    pciutils
  ];
}

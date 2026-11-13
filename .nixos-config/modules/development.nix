{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim zed-editor
    gcc clang gnumake cmake pkg-config
    ripgrep fd eza bat
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}

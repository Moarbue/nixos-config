{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    # Proton-GE is picked per game in Steam (Properties → Compatibility),
    # updated with your flake instead of through protonup-qt.
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    # remotePlay.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true; # lets you run `gamescope -f -W 1920 -H 1080 -- %command%`

  environment.systemPackages = [ pkgs.mangohud ];
}

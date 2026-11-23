{ config, ... }:

let
  home = config.home.homeDirectory;
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop     = "${home}/desktop";
    documents   = "${home}/documents";
    download    = "${home}/downloads";
    music       = "${home}/music";
    pictures    = "${home}/pictures";
    videos      = "${home}/videos";
    templates   = "${home}/templates";
    publicShare = "${home}/public";
  };

  # niri and noctalia expect these; nothing else creates them.
  home.file."pictures/screenshots/.keep".text = "";
  home.file."pictures/wallpapers/.keep".text = "";
}

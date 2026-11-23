{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y"; # `y` = yazi that cd's the shell to where you quit

    settings.mgr = {
      sort_by = "natural";
      sort_dir_first = true;
      show_hidden = false; # toggle with `.`
    };
  };

  # Previews and openers yazi calls out to.
  home.packages = with pkgs; [
    ffmpeg # video thumbnails
    poppler-utils # PDF previews
    imagemagick # image handling
    _7zz # archive previews
    jq # JSON previews
    xdg-utils # xdg-open, used by yazi's default opener
  ];
}

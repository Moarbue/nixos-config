{ ... }:

let
  assign =
    app: types:
    builtins.listToAttrs (
      map (t: {
        name = t;
        value = [ app ];
      }) types
    );
in
{
  # Terminal programs need a terminal when launched from a GUI.
  xdg.desktopEntries = {
    vim-alacritty = {
      name = "Vim";
      genericName = "Text Editor";
      exec = "alacritty -e vim %F";
      categories = [
        "Utility"
        "TextEditor"
      ];
      mimeType = [ "text/plain" ];
    };
    yazi-alacritty = {
      name = "Yazi";
      genericName = "File Manager";
      exec = "alacritty -e yazi %u";
      categories = [
        "Utility"
        "FileManager"
      ];
      mimeType = [ "inode/directory" ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      assign "yazi-alacritty.desktop" [ "inode/directory" ]
      // assign "librewolf.desktop" [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ]
      // assign "org.pwmt.zathura.desktop" [ "application/pdf" ]
      // assign "imv.desktop" [
        "image/png"
        "image/jpeg"
        "image/gif"
        "image/webp"
        "image/bmp"
        "image/tiff"
      ]
      // assign "mpv.desktop" [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "audio/mpeg"
        "audio/flac"
        "audio/ogg"
        "audio/x-wav"
        "audio/mp4"
      ]
      // assign "vim-alacritty.desktop" [
        "text/plain"
        "text/markdown"
        "application/json"
        "application/x-shellscript"
        "text/x-csrc"
        "text/x-chdr"
        "text/x-c++src"
        "text/x-python"
      ];
  };
}

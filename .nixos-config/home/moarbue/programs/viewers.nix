{ pkgs, ... }:

{
  # PDF: minimal, vim keys. Status bar and command line hidden;
  # Ctrl+n / Ctrl+m toggle them.
  programs.zathura = {
    enable = true;
    options = {
      guioptions = "";
      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
    };
  };

  programs.imv.enable = true;

  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
      vo = "gpu-next";
      keep-open = true;
      save-position-on-quit = true;
    };
    # MPRIS: lets noctalia's media widget and the XF86Audio keys control mpv.
    scripts = [ pkgs.mpvScripts.mpris ];
  };
}

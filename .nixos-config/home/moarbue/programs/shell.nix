{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      size = 50000;
      save = 50000;
      share = true;       # all open shells share history
      ignoreDups = true;
      ignoreSpace = true; # commands starting with a space are not saved
    };
  };

  programs.starship = {
    enable = true;
    settings.add_newline = false;
  };

  programs.fzf.enable = true;   # Ctrl-R history, Ctrl-T files, Alt-C dirs
  programs.zoxide.enable = true; # `z <partial-dir>`; cd is left alone

  # `nh os switch` / `nh os build` / `nh os switch -u` (update inputs first):
  # nicer output and a diff of what changes. Needs the flake path.
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/.nixos-config";
  };

  # Modern CLI tools. eza adds its own aliases (ls, ll, la, lt, lla).
  # grep/find/cat are deliberately NOT aliased to rg/fd/bat: the flags differ
  # and pasted commands break. Call `rg`, `fd`, `bat` explicitly.
  programs.eza = {
    enable = true;
    icons = "auto";
    enableZshIntegration = true;
  };
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

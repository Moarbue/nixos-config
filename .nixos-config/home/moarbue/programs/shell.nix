{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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

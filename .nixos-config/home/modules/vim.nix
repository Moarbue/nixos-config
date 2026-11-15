{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    packageConfigurable = pkgs.vim-full;

    settings = {
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      number = true;
    };

    extraConfig = ''
      set clipboard=unnamedplus
      set softtabstop=4
    '';
  };
}

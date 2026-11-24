{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    # Installed by Zed on first start (needs network).
    extensions = [
      "nix"
      "toml"
      "kanagawa-themes"
      "typst"
    ];

    # Language servers / formatters Zed finds on PATH.
    extraPackages = with pkgs; [
      nixd
      nixfmt
      clang-tools
      tinymist
    ];

    userSettings = {
      vim_mode = true;
      vim.use_system_clipboard = "always"; # same as clipboard=unnamedplus in vim.nix

      theme = {
        mode = "dark";
        dark = "Kanagawa Wave"; # verify exact name in the theme picker
        light = "Kanagawa Lotus";
      };

      ui_font_family = config.my.font.family;
      buffer_font_family = config.my.font.family;
      ui_font_size = config.my.font.editorSize;
      buffer_font_size = config.my.font.editorSize;

      tab_size = 4;
      format_on_save = "on";
      load_direnv = "shell_hook";

      auto_update = false; # Nix manages the version
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      lsp = {
        clangd.binary = {
          path = lib.getExe' pkgs.clang-tools "clangd";
          arguments = [
            "--background-index"
            "--clang-tidy"
            # Lets clangd ask the Nix-wrapped compiler for its include paths.
            "--query-driver=/nix/store/*/bin/*"
          ];
        };
        tinymist.settings = {
          exportPdf = "onSave";
          formatterMode = "typstyle";
        };
      };

      languages.Nix = {
        tab_size = 2; # nixfmt style
        language_servers = [
          "nixd"
          "!nil"
        ];
        formatter.external = {
          command = "nixfmt";
          arguments = [ ];
        };
      };
    };
  };
}

{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "moarbue";
        email = "83272310+Moarbue@users.noreply.github.com";
      };
      init.defaultBranch = "main";
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}

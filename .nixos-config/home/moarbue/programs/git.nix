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
  };
}

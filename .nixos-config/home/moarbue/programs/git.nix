{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "moarbue";
        email = "83272310+Moarbue@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      # Lets `git log --show-signature` / `git verify-commit` check signatures
      # from both machines (public keys, kept in this repo).
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };

  xdg.configFile."git/allowed_signers".source = ../allowed_signers;
}

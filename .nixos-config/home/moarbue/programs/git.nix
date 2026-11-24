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
      alias = {
        # Colorful one-line graph: hash, relative date, subject, author, refs.
        lg = "log --graph --abbrev-commit --decorate --all --format=format:'%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
        # Short status with branch line; git colors it automatically.
        st = "status --short --branch";
      };
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

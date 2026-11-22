# Keys are generated per device (`ssh-keygen -t ed25519`) and never stored in
# this repo. This only configures how they are used.
{ ... }:

{
  # Caches the unlocked key so the passphrase is asked once per session.
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = "yes";
      };

      "*" = {
        AddKeysToAgent = "yes";
      };
    };
  };
}

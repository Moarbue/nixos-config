# opencode (AI coding agent for the terminal).
# Don't put API keys here — they'd end up world-readable in the Nix store.
# Authenticate once per machine with `opencode auth login`
# (stored in ~/.local/share/opencode/auth.json).
{ ... }:

{
  programs.opencode = {
    enable = true;

    # Declarative defaults go here; see `programs.opencode.settings`, e.g.:
    # settings = {
    #   model = "anthropic/claude-sonnet-4-5";
    #   autoupdate = false;
    # };
  };
}

# Home-manager overrides for the ThinkPad.
{ ... }:

{
  my.font.size = 12;

  my.niri.touchpad = true;
  my.niri.touchpadSpeed = -0.1;
  my.niri.trackpointSpeed = -0.5;
  my.niri.touchpadScrollFactor = 0.4;
  # 1920x1200 on 13.3" — adjust the scale to taste. Run `niri msg outputs`
  # to confirm the connector name.
  my.niri.outputs = ''
    output "eDP-1" {
        scale 1.25
    }
  '';

  programs.noctalia.settings = {
    bar.main.margin_ends = 40;
    idle.behavior.lock.enabled = true;
  };
}

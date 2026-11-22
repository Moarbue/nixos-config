# Home-manager overrides for the desktop.
{ ... }:

{
  my.font.size = 16;

  my.niri.outputs = ''
    output "ViewSonic Corporation VX2458-mhd VHT191500830" {
        mode "1920x1080@144.001"
        scale 1.0
        transform "normal"
    }
  '';

  programs.noctalia.settings.bar.main.margin_ends = 180;
}

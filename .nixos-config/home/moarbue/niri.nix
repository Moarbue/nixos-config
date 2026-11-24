# Builds ~/.config/niri/config.kdl from
#   - a generated part (keyboard, pointer devices, outputs, cursor, paths)
#   - the static niri/base.kdl
# and validates the result at build time with `niri validate`.
{
  config,
  pkgs,
  osConfig,
  ...
}:

let
  cfg = config.my.niri;
  xkb = osConfig.services.xserver.xkb;
  cursor = config.home.pointerCursor;

  pointerDevices =
    if cfg.touchpad then
      ''
        touchpad {
            tap
            dwt
            natural-scroll
            accel-speed ${toString cfg.touchpadSpeed}
            scroll-factor ${toString cfg.touchpadScrollFactor}
        }

        trackpoint {
            accel-speed ${toString cfg.trackpointSpeed}
        }
      ''
    else
      ''
        touchpad {
            off
        }

        trackpoint {
            off
        }
      '';

  generated = ''
    input {
        keyboard {
            xkb {
                layout "${xkb.layout}"
                variant "${xkb.variant}"
            }
            numlock
        }

        ${pointerDevices}

        focus-follows-mouse
    }

    ${cfg.outputs}

    cursor {
        xcursor-theme "${cursor.name}"
        xcursor-size ${toString cursor.size}
    }

    screenshot-path "${config.home.homeDirectory}/pictures/screenshots/screenshot_from_%Y-%m-%d_%H-%M-%S.png"
  '';

  raw = pkgs.writeText "niri-config-raw.kdl" (generated + "\n" + builtins.readFile ./niri/base.kdl);

  validated = pkgs.runCommand "niri-config.kdl" { nativeBuildInputs = [ pkgs.niri ]; } ''
    niri validate -c ${raw}
    cp ${raw} $out
  '';
in
{
  xdg.configFile."niri/config.kdl".source = validated;
}

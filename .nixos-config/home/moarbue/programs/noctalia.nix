{ config, lib, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true; # replaces spawn-at-startup in niri

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Kanagawa";
        pure_black_dark = false;
      };

      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        transition = [ "fade" "wipe" "disc" "stripes" "zoom" ];
        transition_duration = 1500;
        transition_on_startup = false;
        sync_transitions = true;
        directory = "${config.home.homeDirectory}/pictures/wallpapers";
        default.path = "${config.home.homeDirectory}/pictures/wallpapers/galaxy.jpg";

        automation = {
          enabled = false;
          interval_seconds = 1800;
          order = "random";
          recursive = true;
        };
      };

      backdrop = {
        enabled = true;
        blur_intensity = 0.5;
        tint_intensity = 0.3;
      };

      bar.main = {
        position = "top";
        thickness = 34;
        background_opacity = 1.0;
        compositor_blur = true;
        radius = 12;
        margin_ends = lib.mkDefault 40; # overridden per host
        margin_edge = 10;
        padding = 14;
        widget_spacing = 6;
        scale = 1.0;
        font_scale = 1.0;
        shadow = true;
        auto_hide = false;
        reserve_space = true;
        capsule = false;

        start = [ "launcher" "wallpaper" "workspaces" ];
        center = [ "clock" ];
        end = [
          "media" "tray" "notifications" "clipboard"
          "network" "bluetooth" "volume" "brightness"
          "battery" "control-center" "session"
        ];
      };

      notification = {
        enable_daemon = true;
        show_app_name = true;
        show_actions = true;
        keep_dismissed_in_history = true;
        group_by_app = true;
        layer = "top";
        background_opacity = 0.97;
        border = true;
      };

      idle = {
        pre_action_fade_seconds = 2.0;

        behavior.lock = {
          timeout = 600;
          action = "lock";
          enabled = lib.mkDefault false; # enabled on the laptop
        };

        behavior.screen-off = {
          timeout = 660;
          action = "screen_off";
          enabled = true;
        };
      };

      shell = {
        font_family = config.my.font.family;
        polkit_agent = true;
        time_format = "{:%H:%M}";
        date_format = "%A, %x";
        corner_radius_scale = 1.0;
        settings_show_advanced = true;
        clipboard_enabled = true;
        clipboard_history_max_entries = 100;

        panel = {
          transparency_mode = "solid";
          borders = true;
          border_width = 1.0;
          shadow = true;
        };

        launcher = {
          layout = "simple";
          width = 760;
          search_position = "top";
          default_view = "recent";
          categories = true;
          show_icons = true;
          track_usage = true;
          sort_by_usage = true;
        };

        shadow = {
          direction = "down";
          alpha = 0.55;
        };

        animation = {
          enabled = true;
          speed = 1.0;
        };
      };

      audio = {
        enable_overdrive = false;
        enable_sounds = false;
        enable_volume_sounds = true;
        enable_notification_sounds = true;
        sound_volume = 0.5;
        sound_theme = "freedesktop";
      };

      bluetooth = {
        connect_when_enabled = false;
        connection_notifications = false;
      };
    };
  };
}

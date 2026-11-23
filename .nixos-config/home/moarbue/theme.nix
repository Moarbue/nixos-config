{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };
    # libadwaita apps ignore GTK themes; they follow color-scheme below.
    gtk4.theme = config.gtk.theme;
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # Qt apps follow Adwaita dark. Few Qt apps here, so keep it simple.
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
}

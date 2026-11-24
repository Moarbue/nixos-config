{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:

let
  home = config.home.homeDirectory;
  base = "/run/media/moarbue/MOARSSD/3_Backups";
  repo = "${base}/${osConfig.networking.hostName}/home";
  dirs = map (d: "${home}/${d}") [
    "desktop"
    "documents"
    "downloads"
    "music"
    "pictures"
    "projects"
    "videos"
  ];
in
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "backup-home";
      runtimeInputs = [ pkgs.restic ];
      text = ''
        if [ ! -d "${base}" ]; then
          echo "SSD not mounted: ${base} not found" >&2
          exit 1
        fi

        # First run: create and initialise the repository (asks for a new password).
        if [ ! -f "${repo}/config" ]; then
          mkdir -p "${repo}"
          restic init -r "${repo}"
        fi

        restic backup -r "${repo}" --exclude-caches \
          --exclude "${home}/pictures/wallpapers" \
          ${lib.escapeShellArgs dirs}

        restic forget -r "${repo}" --prune \
          --keep-daily 7 --keep-weekly 4 --keep-monthly 6
      '';
    })
  ];
}

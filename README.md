# nixos-config

NixOS flake for my desktop and laptop: [niri](https://github.com/niri-wm/niri) as the compositor,
[home-manager](https://github.com/nix-community/home-manager) for the user environment and
[noctalia](https://github.com/noctalia-dev/noctalia) as the shell.

This repository lives in `$HOME` and only tracks the config itself (see `.gitignore`).
The flake is in `~/.nixos-config`.

## Hosts

| Host     | Machine                              | Notes                                           |
| -------- | ------------------------------------ | ----------------------------------------------- |
| `moarpc` | Desktop PC (AMD CPU, GTX 970, Btrfs) | legacy NVIDIA 580 driver, Steam, gaming         |
| `moarlt` | ThinkPad X13 Gen 3 (AMD CPU, Radeon) | LUKS, hibernation, power-profiles-daemon, fwupd |

## Structure

| Path                      | Purpose                                                            |
| ------------------------- | ------------------------------------------------------------------ |
| `.nixos-config/flake.nix` | Inputs and outputs; `mkHost` builds a system from a host name      |
| `modules/nixos/`          | Shared NixOS modules, imported per host as needed                  |
| `hosts/<name>/`           | Everything specific to one machine, including its home overrides   |
| `home/moarbue/`           | Shared home-manager config (one module per program in `programs/`) |
| `templates/`              | Flake templates for development shells                             |

Machine differences are kept small: shared modules read the `my.*` options defined in
`home/moarbue/options.nix`, and each host sets them in `hosts/<name>/home.nix`.
The niri config is assembled from a generated part and a static KDL file, and validated
with `niri validate` at build time.

## Usage

Run from `~/.nixos-config`. Hostnames match the flake output names.

```sh
nh os switch            # apply (nicer output and a diff of the changes)
nh os switch -u         # update flake inputs first, then apply
nh os build             # build without activating
nix flake check         # evaluate everything
```

Plain NixOS equivalent: `sudo nixos-rebuild switch --flake .#$(hostname)`.

New host: add `hosts/<name>/{default,home}.nix` and register the name in `flake.nix`.

New project from a template: `nix flake init -t self#c-cpp`.

## Manual steps (not managed by Nix)

- **SSH key**: one per device, never stored in this repo.
  `ssh-keygen -t ed25519 -C "moarbue@$(hostname)"`, add the public key on GitHub, and add it to
  `home/moarbue/allowed_signers` so commit signatures verify on every machine.
- **opencode**: `opencode auth login` once per machine.
- **Monitors**: check output names and scale with `niri msg outputs` and adjust `my.niri.outputs`
  in `hosts/<name>/home.nix`.
- **Snapshots**: `sudo btrfs subvolume create /.snapshots /home/.snapshots` once per machine
  before the first switch.
- **Hibernation (laptop)**: create the swapfile in `/swap` and set `my.hibernate.resumeOffset`
  in `hosts/moarlt/default.nix` (see the header of `modules/nixos/hibernate.nix`).

## Use of AI

AI was heavily used to write the code and docs.

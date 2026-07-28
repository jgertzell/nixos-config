# System Maintenance

Nix based system configuration for my personal computers.

## Layout

- `flake.nix`: entry point for the system flake.
- `hosts/`: host-specific imports and hardware configuration.
- `modules/nixos/`: reusable NixOS modules grouped by concern.
- `home/`: Home Manager configuration and user-level programs.
- `dotfiles/`: plain dotfiles that can be linked through Home Manager.

## `/etc/nixos`

This repository is the source of truth for the machine configuration. `/etc/nixos` is expected to be a symlink to this repository.

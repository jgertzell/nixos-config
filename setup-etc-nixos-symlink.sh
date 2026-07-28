#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target="/etc/nixos"
backup="/etc/nixos.backup"

if [[ "$repo_dir" != "/home/jgertzell/system-maintenance" ]]; then
  echo "This script is expected to run from /home/jgertzell/system-maintenance."
  echo "Detected: $repo_dir"
  exit 1
fi

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run with sudo: sudo $repo_dir/setup-etc-nixos-symlink.sh"
  exit 1
fi

if [[ -L "$target" ]]; then
  current="$(readlink "$target")"
  if [[ "$current" == "$repo_dir" ]]; then
    echo "$target already points to $repo_dir"
    exit 0
  fi

  echo "$target is already a symlink to $current; not changing it."
  exit 1
fi

if [[ ! -d "$target" ]]; then
  echo "$target does not exist or is not a directory; not changing it."
  exit 1
fi

if [[ -e "$backup" ]]; then
  echo "$backup already exists; not overwriting it."
  exit 1
fi

mv "$target" "$backup"
ln -s "$repo_dir" "$target"

echo "Moved $target to $backup"
echo "Linked $target -> $repo_dir"
echo "Verify with: sudo nixos-rebuild dry-build --flake /etc/nixos#$(hostname)"

fish_add_path --prepend $HOME/.dotnet/tools
set -gx SSL_CERT_DIR /etc/ssl/certs:$HOME/.aspnet/dev-certs/trust

if status is-interactive
  alias nixos-switch 'sudo nixos-rebuild switch --flake /etc/nixos#nix-laptop'
  alias nvim-cheatsheet 'glow /etc/nixos/docs/neovim.md'
  alias nvim-help 'glow /etc/nixos/docs/neovim.md'

  set -g fish_history_max 1000000
  set -gx TZDIR /etc/zoneinfo
end

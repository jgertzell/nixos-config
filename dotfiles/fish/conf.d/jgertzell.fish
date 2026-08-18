fish_add_path --prepend $HOME/.dotnet/tools
set -gx SSL_CERT_DIR /etc/ssl/certs:$HOME/.aspnet/dev-certs/trust
set -gx LD_LIBRARY_PATH /run/current-system/sw/share/nix-ld/lib $LD_LIBRARY_PATH

if status is-interactive
  function nixos-switch
    sudo nixos-rebuild switch --flake /etc/nixos#(hostname)
  end

  alias nvim-cheatsheet 'glow /etc/nixos/docs/neovim.md'
  alias nvim-help 'glow /etc/nixos/docs/neovim.md'

  set -g fish_history_max 1000000
  set -gx TZDIR /etc/zoneinfo
end

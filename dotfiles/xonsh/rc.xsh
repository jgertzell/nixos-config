$XONSH_HISTORY_SIZE = (1000000, "commands")
$TZDIR = "/etc/zoneinfo"
$SSL_CERT_DIR = f"/etc/ssl/certs:{$HOME}/.aspnet/dev-certs/trust"
$PATH.insert(0, f"{$HOME}/.dotnet/tools")
aliases.update({
    "nixos-switch": "sudo nixos-rebuild switch --flake /etc/nixos#nix-laptop",
    "nvim-cheatsheet": "glow /etc/nixos/docs/neovim.md",
    "nvim-help": "glow /etc/nixos/docs/neovim.md",
})

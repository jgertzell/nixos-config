$XONSH_HISTORY_SIZE = (1000000, "commands")
$TZDIR = "/etc/zoneinfo"
$SSL_CERT_DIR = f"/etc/ssl/certs:{$HOME}/.aspnet/dev-certs/trust"
$PATH.insert(0, f"{$HOME}/.dotnet/tools")

def nixos_switch(args, stdin=None):
    return ["sudo", "nixos-rebuild", "switch", "--flake", f"/etc/nixos#{$(hostname).strip()}"] + args

aliases.update({
    "nixos-switch": nixos_switch,
    "nvim-cheatsheet": "glow /etc/nixos/docs/neovim.md",
    "nvim-help": "glow /etc/nixos/docs/neovim.md",
})

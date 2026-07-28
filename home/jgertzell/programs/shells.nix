{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    glow
    xonsh
    fish
    nushell
  ];

  programs.fish.enable = true;

  xdg.configFile."fish/conf.d/jgertzell.fish".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/fish/conf.d/jgertzell.fish";
  xdg.configFile."nushell/config.nu".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nushell/config.nu";
  xdg.configFile."nushell/zoxide.nu".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nushell/zoxide.nu";
  xdg.configFile."xonsh/rc.xsh".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/xonsh/rc.xsh";
  xdg.configFile."powershell/Microsoft.PowerShell_profile.ps1".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/powershell/Microsoft.PowerShell_profile.ps1";

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}

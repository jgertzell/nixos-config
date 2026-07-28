{ config, pkgs, ... }:

let
  dotnet = pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
    sdk_6_0
    sdk_7_0
    sdk_8_0
    sdk_9_0
    sdk_10_0
    aspnetcore_6_0
    aspnetcore_7_0
    aspnetcore_8_0
    aspnetcore_9_0
    aspnetcore_10_0
  ]);
in

{
  home.packages = with pkgs; [
    fd
    gcc
    lazygit
    neovim
    dotnet
    lua-language-server
    netcoredbg
    ripgrep
    roslyn-ls
    stylua
    tree-sitter
    vscode-langservers-extracted
    yaml-language-server
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.file.".local/bin/vi".source = "${pkgs.neovim}/bin/nvim";
  home.file.".local/bin/vim".source = "${pkgs.neovim}/bin/nvim";

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";
}

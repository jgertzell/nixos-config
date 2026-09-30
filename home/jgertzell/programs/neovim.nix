{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    gcc
    lazygit
    neovim
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

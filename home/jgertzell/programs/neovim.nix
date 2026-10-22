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

  # Use the Nix-patched dotnet host instead of the global tool's generic apphost.
  home.file.".local/share/nvim/bin/dotnet-easydotnet" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -eu
      for dll in "$HOME"/.dotnet/tools/.store/easydotnet/*/easydotnet/*/tools/net*/any/EasyDotnet.IDE.dll; do
        if [ -f "$dll" ]; then
          exec dotnet "$dll" "$@"
        fi
      done
      printf '%s\n' 'EasyDotnet is not installed. Run install-dotnet-tools.' >&2
      exit 1
    '';
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";
}

{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.dotnet/tools"
  ];

  home.sessionVariables = {
    # .NET falls back to /usr/share/zoneinfo unless TZDIR points at NixOS's timezone database.
    TZDIR = "/etc/zoneinfo";
    # Keep public CA roots in the bundle while Aspire adds its localhost certificate here.
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    SSL_CERT_DIR = "/home/${username}/.aspnet/dev-certs/trust";
    # VS Code's launcher rewrites LD_LIBRARY_PATH; nix-ld consumes this variable
    # to expose native dependencies to downloaded tools such as C# Dev Kit.
    NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.curl
      pkgs.glib
      pkgs.icu
      pkgs.krb5
      pkgs.libsecret
      pkgs.openssl
      pkgs.stdenv.cc.cc
      pkgs.zlib
    ];
  };

  home.packages = [ ];
}

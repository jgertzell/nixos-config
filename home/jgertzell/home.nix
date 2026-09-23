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
    # Aspire exports the per-user development certificate here on Linux.
    SSL_CERT_DIR = "/etc/ssl/certs:/home/${username}/.aspnet/dev-certs/trust";
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
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

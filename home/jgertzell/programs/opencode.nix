{ pkgs, ... }:

{
  programs.opencode = {
    enable = true;
    # Temporary workaround for the dependency hash mismatch in nixpkgs 2.2.5.
    # Drop this override once the pinned package is fixed or updated.
    package = if pkgs.opencode.version == "2.2.5" then
      pkgs.opencode.overrideAttrs (old: {
        node_modules = old.node_modules.overrideAttrs {
          outputHash = "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
        };
      })
    else pkgs.opencode;
  };
}

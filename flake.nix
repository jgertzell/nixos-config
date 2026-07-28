{
  description = "jgertzell system and home configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "jgertzell";
      mkHost = { hostname, hostModule, homeModules ? [ ] }:
        nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username hostname; };

        modules = [
          hostModule

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs username hostname; };
              users.${username} = {
                imports = [ ./home/jgertzell ] ++ homeModules;
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        nix-laptop = mkHost {
          hostname = "nix-laptop";
          hostModule = ./hosts/nix-laptop;
          homeModules = [ ./home/jgertzell/profiles/desktop.nix ];
        };
        nix-desktop = mkHost {
          hostname = "nix-desktop";
          hostModule = ./hosts/nix-desktop;
          homeModules = [ ./home/jgertzell/profiles/desktop.nix ];
        };
        nix-mediaserver = mkHost {
          hostname = "nix-mediaserver";
          hostModule = ./hosts/nix-mediaserver;
        };
      };
    };
}

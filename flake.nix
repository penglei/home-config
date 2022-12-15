{
  description = "penglei's Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsForNixOS.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = github:Mic92/sops-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nil-language-server = {
      url = "github:oxalica/nil";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgsForNixOS,
    flake-utils,
    home-manager,
    sops-nix,
    nil-language-server,
    ... 
  }@inputs:
    let
      inherit (nixpkgs) lib;

      #systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ]
      systems = map (x: "${x.arch}-${x.os}") (lib.cartesianProductOfSets { os = ["darwin" "linux"]; arch = ["aarch64" "x86_64" ];} );
      eachSystem = f: (flake-utils.lib.eachSystem systems f); 

    in eachSystem (system: let

      pkgOverlays = [
        (import ./pkgs/all.nix)
        (final: prev: {
          nil-language-server = nil-language-server.packages.${system}.nil;
        })
      ];
      pkgs = nixpkgs.legacyPackages.${system}.appendOverlays pkgOverlays;
      #pkgs = import nixpkgs { inherit system; overlays = pkgOverlays; }; 

      profiles = import ./profiles.nix {inherit pkgs self system home-manager;};
    in {
      overlays.default = lib.lists.foldr (a: i: a // i) {} pkgOverlays;

      # home-manager bootstrap: `nix shell nixpkgs#git; nix develop; home-manager switch --flake .#XXXX`
      devShells.default = pkgs.mkShell {
        buildInputs = [ home-manager.defaultPackage.${system}];
      };

      # *home-manaer* has 3 scenarios:
      ##  1. macOS only -- has launchd service
      ##  2. some others Linux distribution 
      ##  3. as a nixos module

      #packages.${system}.homeConfigurations = self.homeConfigurations;
      packages.homeConfigurations =
        profiles.creator.standalone "penglei" //
        profiles.creator.standalone "ubuntu";


      ## nixos linux only
      packages.nixosConfigurations = {
        #develop
        utm-vm = 
          let hostname = "utm-vm";
              username = "penglei";
          in nixpkgsForNixOS.lib.nixosSystem {
            inherit system;
            specialArgs = {
              nixpkgs = nixpkgsForNixOS;
            };
            modules = [
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.penglei.imports = profiles.hm.linux.modules;
                #home-manager.extraSpecialArgs = {};
              }

              {
                nixpkgs.overlays = pkgOverlays;
              }

              sops-nix.nixosModules.sops
            ] ++ [
              ./stuff/etc-nixos/configuration.nix
              ./stuff/etc-nixos/hardware-configuration.nix
              {
                networking.hostName = hostname;
              }
            ];
        };

        #proxy&develop
        hk-alpha = {

        };

        #proxy&dns
        sg-alpha = {

        };
      };
    }); # each system
}

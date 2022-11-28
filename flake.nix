{
  description = "penglei's Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, flake-utils, home-manager, ... }:
    let
      inherit (nixpkgs) lib;

      #systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ]
      systems = map (x: "${x.arch}-${x.os}")
        (lib.cartesianProductOfSets { os = ["darwin" "linux"]; arch = ["aarch64" "x86_64" ];} );
      pkgsWithOverlay = overlay: system: (import nixpkgs {
        inherit system;
        overlays = [overlay];
      });
      eachSystem = f: (flake-utils.lib.eachSystem systems f); 
      nixpkgsOverlays = import ./pkgs/all.nix ;

    in eachSystem (system: let
      #pkgs = pkgsWithOverlay nixpkgsOverlays system; 
      pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [ nixpkgsOverlays ];
      profiles = import ./profiles.nix {inherit pkgs self system home-manager;};
    in {
      overlays.default = nixpkgsOverlays;

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
          in nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit nixpkgs;
            };
            modules = [
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.penglei.imports = profiles.hm.linux.modules;
              }

              {
                nixpkgs.overlays = [ nixpkgsOverlays ];
              }
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

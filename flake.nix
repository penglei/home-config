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
      pkgsOverlay = import ./pkgs/all.nix ;

    in eachSystem (system: let
      #pkgs = pkgsWithOverlay pkgsOverlay system; 
      pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [ pkgsOverlay ];
      profiles = import ./profiles.nix {inherit pkgs self system home-manager;};
    in {
      overlays.default = pkgsOverlay;

      # bootstrap: `nix develop; home-manager switch --flake .#XXXX`
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
        utm-vm = {

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

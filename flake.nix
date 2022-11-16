{
  description = "Home Manager configuration of penglei(ybyte)";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      # bootstrap: `nix develop; home-manager switch --flake .#penglei`
      devShells.${system}.default = pkgs.mkShell { buildInputs = [ home-manager.defaultPackage.${system}]; };

      # *home-manaer* has 3 scenarios:
      ##  macOS only -- has launchd service
      ##  some others Linux distribution 
      ##  as nixos module

      # *nixos*;
      ## nixos linux only (I don't use nix-darwin)

      homeConfigurations.penglei = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./module-darwin.nix
          ./hm-modules/darwin-application.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      nixosConfigurations = {
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
    };
}

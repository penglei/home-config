{
  description = "penglei's system configuration powered by Nix";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsForNixOS.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgsForNixOS, flake-utils, hyprland, home-manager
    , sops-nix, nil-language-server, ... }@inputs:
    let
      inherit (nixpkgs) lib;

      #systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ]
      systems = map (x: "${x.arch}-${x.os}") (lib.cartesianProductOfSets {
        os = [ "darwin" "linux" ];
        arch = [ "aarch64" "x86_64" ];
      });
      eachSystem = f: (flake-utils.lib.eachSystem systems f);

    in eachSystem (system:
      let
        pkgOverlays = [
          (import ./pkgs/all.nix)
          (final: prev: {
            nil-language-server = nil-language-server.packages.${system}.nil;
          })
        ];
        pkgs = nixpkgs.legacyPackages.${system}.appendOverlays pkgOverlays;
        #pkgs = import nixpkgs { inherit system; overlays = pkgOverlays; }; 

        profiles = import ./profiles.nix { inherit self pkgs system home-manager sops-nix; };
      in {
        packages.nixpkgs = pkgs; #debug overrided nixpkgs: nix build .#nixpkgs.passage
        overlays.default = lib.lists.foldr (a: i: a // i) { } pkgOverlays;

        # home-manager bootstrap: `nix shell nixpkgs#git; nix develop; home-manager switch --flake .#XXXX`
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            home-manager.defaultPackage.${system} #home-manager command
            ssh-to-pgp ssh-to-age
          ];
          shellHook = ''
            export PATH=$(pwd)/result/bin:''$PATH
          '';
        };

        # *home-manaer* has 3 scenarios:
        ##  1. macOS only -- has launchd service
        ##  2. some others Linux distribution
        ##  3. as a nixos module

        #packages.${system}.homeConfigurations = self.homeConfigurations;
        packages.homeConfigurations =
            profiles.hm-creator.standalone "penglei" //
            profiles.hm-creator.standalone "ubuntu";

        ## nixos linux only
        packages.nixosConfigurations = {
          utm-vm = profiles.nixos-creator {
            inherit system;
            nixpkgs = nixpkgs; #nixpkgsForNixOS
            overlays = pkgOverlays;
            hostname = "utm-vm";
            username = "penglei";
            modules = [ ./nixos/utm-vm/all.nix ];
          };

          tart-vm = profiles.nixos-creator {
            inherit system;
            nixpkgs = nixpkgs; #nixpkgsForNixOS
            overlays = pkgOverlays;
            hostname = "tart-vm";
            username = "penglei";
            modules = [ ./nixos/tart-vm/all.nix ];
          };

          router-dev = profiles.nixos-creator {
            inherit system;
            nixpkgs = nixpkgs; #nixpkgsForNixOS
            overlays = pkgOverlays;
            hostname = "router-dev";
            username = "penglei";
            modules = [ ./nixos/router-dev ];
          };

          #proxy&develop
          hk-alpha = {

          };

          #proxy&dns
          sg-alpha = {

          };
        };
        #packages.darwin-rootkit = ./
      }); # each system
}

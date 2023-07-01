{system, profiles, nixpkgs, pkgOverlays, ...}:

rec {
  slim = profiles.nixos-creator {
    inherit system;
    nixpkgs = nixpkgs; #nixpkgsForNixOS
    overlays = pkgOverlays;
    hostname = "nixos";
    username = "penglei";
    modules = [ ./nixos/basic ];
    hm-modules = profiles.hm.slim.modules;
  };
  basic = profiles.nixos-creator {
    inherit system;
    nixpkgs = nixpkgs; #nixpkgsForNixOS
    overlays = pkgOverlays;
    hostname = "nixos";
    username = "penglei";
    modules = [ ./nixos/basic ];
  };
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
    hm-modules = profiles.hm.slim.modules;
  };

  hk-alpha = profiles.nixos-creator {
    inherit system;
    nixpkgs = nixpkgs; #nixpkgsForNixOS
    overlays = pkgOverlays;
    hostname = "hk-alpha";
    username = "penglei";
    modules = [ ./nixos/cloud ];
    hm-modules = profiles.hm.slim.modules;
  };

  sg-alpha = profiles.nixos-creator {
    inherit system;
    nixpkgs = nixpkgs; #nixpkgsForNixOS
    overlays = pkgOverlays;
    hostname = "sg-alpha";
    username = "penglei";
    modules = [ ./nixos/cloud ];
    hm-modules = profiles.hm.slim.modules;
  };
}

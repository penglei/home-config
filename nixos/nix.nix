{ config
, pkgs
, lib
, nixpkgs
, username
, ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    registry.nixpkgs.flake = nixpkgs;

    gc.automatic = true;

    settings = rec {
      auto-optimise-store = true;
      warn-dirty = false;


      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@wheel" username ];
      allowed-users = trusted-users;

      #substituters = [];
      #trusted-public-keys = [];

    };
  };
}


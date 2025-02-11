{ pkgs, nixpkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false; # set env NIX_PATH
    package = pkgs.nixVersions.git; # or versioned attributes like nix_2_4
    registry.nixpkgs.flake = nixpkgs;

    gc.automatic = true;

    settings = rec {
      auto-optimise-store = true;
      use-cgroups = true;
      warn-dirty = false;
      auto-allocate-uids = true;
      experimental-features =
        [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];
      extra-experimental-features = [ "ca-derivations" ];
      trusted-users = [ "@wheel" username ];
      allowed-users = trusted-users;
    };
  };
}


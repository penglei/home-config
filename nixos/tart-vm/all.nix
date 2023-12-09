{lib,...}:

{
  imports = [
    ../nix.nix
    ../modules/configuration.nix
    ../modules/programs.nix
    ../modules/pam.nix

    ./hardware-configuration.nix
    ./networking.nix
    ./services.nix
    ./misc.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  system.stateVersion = "23.11";

  #nixpkgs.config.contentAddressedByDefault = true;
  #nix.settings = {
  #  extra-experimental-features = [ "ca-derivations" ];
  #  substituters = [ "https://cache.ngi0.nixos.org/" ];
  #  trusted-public-keys = [ "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA=" ];
  #};
}

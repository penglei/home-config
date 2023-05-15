{lib,...}:

{
  imports = [
    ../nix.nix
    ../modules/configuration.nix
    ../modules/programs.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./services.nix
    ./misc.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  system.stateVersion = "22.11";
}

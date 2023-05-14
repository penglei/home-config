{lib,...}:

{
  imports = [
    ../nix.nix
    ../modules/configuration.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./services.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  system.stateVersion = "22.11";
}

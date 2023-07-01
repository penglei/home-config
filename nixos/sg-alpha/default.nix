{lib, config, ...}:

{
  imports = [
    ./services.nix
    ./sops.nix
    ./networking.nix
    ../modules/ssserver.nix
  ];
}

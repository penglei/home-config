{lib, config, ...}:

{
  imports = [
    ./services.nix
    ./sops.nix
    ../modules/ssserver.nix
  ];
}

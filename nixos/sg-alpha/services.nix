{ config, lib, pkgs, ... }: with lib;

{
    services.dnscrypt-proxy2.enable = true
}

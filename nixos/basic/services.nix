# List services that you want to enable:
{ config, pkgs, lib, ... }:

{
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "yes";
}

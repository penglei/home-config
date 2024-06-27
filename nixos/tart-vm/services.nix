# List services that you want to enable:
{ config, pkgs, lib, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  services.timesyncd.enable = false;
}

# List services that you want to enable:
{ config
, pkgs
, lib
, ...
}:

{
  services.qemuGuest.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "yes";

  services.tailscale.enable = true;

  virtualisation.docker.enable = true;
}


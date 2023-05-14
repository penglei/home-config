# List services that you want to enable:
{ config
, pkgs
, lib
, ...
}:

{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "yes";

}

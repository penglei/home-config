# List services that you want to enable:
{ config
, pkgs
, lib
, ...
}:

{
  services.qemuGuest.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
      StreamLocalBindUnlink = "yes"; 
    };
    #extraConfig = ''
    #    Match User test
    #        PasswordAuthentication yes
    #        ForceCommand internal-sftp
    #        ChrootDirectory /run/home/test
    #'';
  };

  services.tailscale.enable = true;

  virtualisation.docker.enable = true;
}


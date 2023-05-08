{ config
, pkgs
, lib
, ...
}:

{
  services.tailscale.enable = true;
  services.qemuGuest.enable = true;
}


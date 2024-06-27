{ config, pkgs, lib, hostname, ... }:

#https://nixos.wiki/wiki/Networking
{
  networking = { hostName = hostname; };
}


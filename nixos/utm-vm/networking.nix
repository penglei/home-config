{hostname}: { config, pkgs, lib, ... }:

#https://nixos.wiki/wiki/Networking
{
  networking = {
    hostName = hostname;

    useDHCP = false;
    dhcpcd.enable = false;
    defaultGateway = "192.168.65.1";
    nameservers = ["192.168.65.1"];
    interfaces.enp0s1 = {
      ipv4.addresses = [{
        address = "192.168.65.5";
        prefixLength = 24;
      }];
    };
  };
}

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;


# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
# (the default) this is the recommended approach. When using systemd-networkd it's
# still possible to use this option, but it's recommended to use it in conjunction
# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
# networking.useDHCP = lib.mkDefault true;
# networking.interfaces.docker0.useDHCP = lib.mkDefault true;
# networking.interfaces.enp0s9.useDHCP = lib.mkDefault true;

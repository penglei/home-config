{ config, lib, ... }:

{
  imports = [
    ../nix.nix
    ../modules/configuration.nix
    ../modules/programs.nix
    ../modules/openssh.nix
    ../modules/pam.nix
    ../modules/sing-box-client.nix
  ];

  #These modules ared loaded in boot stage-1, which are required
  #to recognize block device that contains rootfs for stage-2.
  #Run `nixos-generate-config` to determine the required modules.
  boot.initrd.availableKernelModules = [ "ahci" "megaraid_sas" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.loader = {
    timeout = 1;

    # grub.enable = true;
    # grub.device = "/dev/sda";

    systemd-boot.enable = true;
    efi.efiSysMountPoint = "/boot";
    efi.canTouchEfiVariables = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/disk-main-esp";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/disk-main-root";
    fsType = "ext4";
  };

  #disable network scripting configuration
  #https://wiki.nixos.org/wiki/Systemd/networkd
  #https://www.reddit.com/r/NixOS/comments/1fwh4f0/networkinginterfaces_vs_systemdnetworknetworks/
  networking.useNetworkd = true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ]; # extras
  };
  systemd.network.enable = true;
  systemd.network.networks."20-lan-primary" = {
    matchConfig.Name = "eno3";
    networkConfig.DHCP = "ipv4";
    linkConfig.RequiredForOnline = "routable";
  };
  # boot.kernel.sysctl = { "net.ipv4.conf.all.rp_filter" = 0; };
  systemd.network.links."eno1".enable = false;
  systemd.network.networks."10-lan-secondary" = {
    matchConfig.Name = "eno1";
    networkConfig.DHCP = "ipv4";
    dhcpV4Config = {
      #There are multiple network interfaces on the machine connected to the same local area network.
      #The primary interface has already applied the network configuration obtained from DHCP server,
      #so we do not want this interface to obtain the same configuration again.
      UseDNS = false;
      SendHostname = false;
      #disable default routes.
      # N.B Even if DHCP routing is disabled, the system may still automatically generate a local subnet route
      # based on the subnet mask of the IP address, for example:
      # * If the network interface obtains the address 192.168.1.100/24, the system will automatically
      # add a route for 192.168.1.0/24.
      # * This route is automatically generated by the kernel (unrelated to DHCP) and cannot be directly
      # disabled through systemd-networkd configuration.
      UseRoutes = false;
    };
  };
  systemd.services."systemd-networkd" = {
    environment.SYSTEMD_LOG_LEVEL = "debug";
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "23.05";
}


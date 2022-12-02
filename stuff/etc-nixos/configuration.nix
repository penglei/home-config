# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix # delete it and run command nixos-generate-config to generate again
    ];

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  ## The global useDHCP flag is deprecated, therefore explicitly set to false here.
  ## Per-interface useDHCP will be mandatory in the future, so this generated config
  ## replicates the default behaviour.
  #networking.useDHCP = false;
  #networking.interfaces.enp0s9.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.penglei = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAFQdutHfBohOBte2UWc3+3hBnm0ENPLsMBtp7hzEII+9JnGs8iKPA9/SKnLfABD4QdApP3Ptb5bX4opI6iG4XIafe8dgg8SwS3Kqk5BWY/90BADCrxdl7wsORbT3laaGzz205dzljZf+DWp0dCfSH1JfTPVUmatut+iWZNZMpXDktNsKXh3cjdCv+cWXVSbJkVSt8CFYHqD7/TrCJdQilFBgEoZHYPM6MGIAFCzCdNW4Vzu9GQeq7iodDfYu3BtpAKYQLHLR2WwNjKIevgfOzaChFruYfroWYIMx5RCYcM5IRFuI1BA8bNm9w6bC2EETdhjdnydQrpzxWkGy6otST"
    ];
    shell = pkgs.zsh;
  };

  security.sudo.extraRules= [
    {  users = [ "penglei" ];
      commands = [
         { command = "ALL" ;
           options= [ "NOPASSWD" "SETENV" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget

    #firefox-wayland
    #alacritty # gpu accelerated terminal
    #sway
    #wayland
  ];
  # enable sway window manager
  #programs.sway.enable = true;
  #programs.waybar.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "yes";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  virtualisation.docker.enable = true;
}


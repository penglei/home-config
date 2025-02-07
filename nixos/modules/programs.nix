{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    pstree
    file
    curl
    gnumake
    bridge-utils
    nixVersions.latest
    conntrack-tools
    dnsutils # contains dig, nslookup
    neovim
    lsof
  ]; # merge syntatics
}

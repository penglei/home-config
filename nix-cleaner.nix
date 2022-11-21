{writeShellApplication}: 

writeShellApplication {
  name = "nix-cleaner";
  text = ''
    home-manager expire-generations "$(home-manager generations|head -n 1 | awk -F ' : ' '{print $1}')"
    nix profile wipe-history
  '';
}

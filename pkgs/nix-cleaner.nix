{writeShellApplication}: 

writeShellApplication {
  name = "nix-cleaner";
  text = ''
    if type home-manager > /dev/null
    then
      home-manager expire-generations "$(home-manager generations|head -n 1 | awk -F ' : ' '{print $1}')"
    fi

    nix profile wipe-history
    #nix-env --delete-generations old

    if [[ -f /nix/var/nix/profiles/system ]]; then
      sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
      #sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
    fi
  '';
}

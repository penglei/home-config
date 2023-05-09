{ pkgs
, config
, ...
}:

let 
  keyfileInHome = ".config/sops/age/keys.txt";
  keyfile = "${config.home.homeDirectory}/${keyfileInHome}";
in
{

  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "$HOME/${keyfileInHome}";
  };
  sops =  {
    age.keyFile = keyfile;
    defaultSopsFile = ../../secrets/basic.yaml;

    # secrets.ssh_legacy_key = {
    #   # sopsFile = ./ssh-key.enc
    #   path = "${config.home.homeDirectory}/.ssh/id_rsa";
    # };
  };

}

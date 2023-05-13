{ pkgs
, config
, ...
}:

{
  sops =  {
    # age.keyFile = keyfile;
    # age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    defaultSopsFile = ../../secrets/basic.yaml;

    secrets.hello = {
      path = "/tmp/helloworld-from-sops";
    };
  };

}


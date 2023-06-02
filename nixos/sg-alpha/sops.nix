{ pkgs
, config
, ...
}:

{
  sops =  {
    defaultSopsFile = ../../secrets/basic.yaml;
    secrets."doh_server_key.pem" = {
        sopsFile = ../../secrets/https-server.yaml;
        restartUnits = [ "dnscrypt-proxy2.service" ];
    };
  };
}


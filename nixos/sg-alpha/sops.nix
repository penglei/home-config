{ pkgs
, config
, ...
}:

{
  sops =  {
    defaultSopsFile = ../../secrets/basic.yaml;
    secrets."doh_server_key.pem" = {
        sopsFile = ../../secrets/server.yaml;
        restartUnits = [ "dnscrypt-proxy2.service" ];
    };
    secrets."ssserver.json" = {
        sopsFile = ../../secrets/server.yaml;
        restartUnits = [ "ssserver.service" ];
    };

    templates.ssserver.content = builtins.toJSON {
      "server_port" = 8388;
    };
  };

}


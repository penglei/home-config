{ config, lib, pkgs, ... }: with lib;

#https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml

{
    services.dnscrypt-proxy2 = {
        enable = true;
        settings = {
            listen_addresses = ["127.0.0.1:10053"];
            netprobe_address = "114.114.114.114:53";
            bootstrap_resolvers = ["114.114.114.114:53"];
            doh_client_x509_auth = {
              creds = [
                {
                  root_ca = ../../certs/ca.pem;
                }
              ];
            };
            sources = null;
            server_names = ["fixpoint"];
            static = {
                "static.fixpoint" = {
                     stamp = "sdns://AgcAAAAAAAAADjQzLjE1Ni4xNTIuMjAxABRyZXNvbHZlLmxub3RlMzY1LmNvbQovZG5zLXF1ZXJ5";
                };
            };

            # #server
            # local_doh = {
            #     listen_addresses = [ "0.0.0.0:443" ];
            #     path = "/dns-query";
            #     cert_file = ../../certs/localhost.pem;
            #     cert_key_file = config.sops.secrets."localhost-key.pem".path;
            # };
        };
    };
    systemd.services.dnscrypt-proxy2 = {
      serviceConfig = {
        DynamicUser = mkForce false;
        User = "root";
        Group = "root";
      };
    };
}


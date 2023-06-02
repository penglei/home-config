{ config, lib, pkgs, ... }: with lib;

{
    services.dnscrypt-proxy2 = {
        enable = true;
        settings = {
            local_doh = {
                listen_addresses = [ "0.0.0.0:443" ];
                path = "/dns-query";
                cert_file = ../../files/doh_server.pem;
                cert_key_file = config.sops.secrets."doh_server_key.pem".path;
            };
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

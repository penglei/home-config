{
    pkgs,
    lib,
    config,
    ...
}:

let
  #configFile = config.sops.templates.ssserver.path;
  configFile = config.sops.secrets."ssserver.json".path;
in
{
  systemd.services.ssserver = {
    description = "ssserver daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.shadowsocks-rust pkgs.v2ray-plugin ];
    script = ''
      exec ssserver -c ${configFile}
    '';
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "root";
      Group = "root";
    };
  };
}

{ pkgs, config, ... }:

let homeProfilePath = path: "${config.home.homeDirectory}/${path}";
in {
  launchd.agents.postgresql = {
    enable = true;

    config = {
      ProgramArguments = [ "${pkgs.postgresql}/bin/postgres" ];
      EnvironmentVariables = {
        "PATH" = "${homeProfilePath ".nix-profile/bin"}:${
            homeProfilePath ".local/bin"
          }:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:";
        "SHELL" = "/bin/sh";
      };
      KeepAlive = true;
      RunAtLoad = false;
      StandardErrorPath = "/tmp/postgresql.err.log";
      StandardOutPath = "/tmp/postgresql.out.log";
    };
  };
}


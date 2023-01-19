{ pkgs
, config
, ...
}:

let
  homeProfilePath = path: "${config.home.homeDirectory}/${path}";
in {
  # https://ss64.com/osx/launchctl.html
  launchd.agents.spacebar = {
    enable = true;

    config = {
      ProgramArguments = [ "${pkgs.spacebar}/bin/spacebar" ];
      EnvironmentVariables = {
        "PATH" = "${homeProfilePath ".nix-profile/bin"}:${homeProfilePath ".local/bin"}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:";
        "SHELL" = "/bin/sh";
      };
      KeepAlive = true;
      RunAtLoad = true;
      StandardErrorPath = "/tmp/spacebar.err.log";
      StandardOutPath = "/tmp/spacebar.out.log";
    };
  };
}


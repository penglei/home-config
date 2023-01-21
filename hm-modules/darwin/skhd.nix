{ pkgs
, config
, ...
}:

let
  homeProfilePath = path: "${config.home.homeDirectory}/${path}";
in {
  # https://ss64.com/osx/launchctl.html
  launchd.agents.skhd = {
    enable = true;

    config = {
      ProgramArguments = [ "${pkgs.skhd}/bin/skhd" ];
      EnvironmentVariables = {
        "PATH" = "${homeProfilePath ".nix-profile/bin"}:${homeProfilePath ".local/bin"}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:";
        "SHELL" = "/bin/sh";
      };
      KeepAlive = true;
      RunAtLoad = true;
      ProcessType = "Interactive";
      StandardErrorPath = "/tmp/skhd.err.log";
      StandardOutPath = "/tmp/skhd.out.log";
    };
  };
}


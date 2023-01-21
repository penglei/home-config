{ pkgs
, config
, ...
}:

let
  homeProfilePath = path: "${config.home.homeDirectory}/${path}";
in {
  # https://ss64.com/osx/launchctl.html
  launchd.agents.sketchybar = {
    enable = true;

    config = {
      ProgramArguments = [ "${pkgs.sketchybar}/bin/sketchybar" ];
      EnvironmentVariables = {
        "PATH" = "${homeProfilePath ".nix-profile/bin"}:${homeProfilePath ".local/bin"}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:";
        "SHELL" = "/bin/sh";
      };
      KeepAlive = true;
      RunAtLoad = true;
      StandardErrorPath = "/tmp/sketchybar.err.log";
      StandardOutPath = "/tmp/sketchybar.out.log";
    };
  };
}


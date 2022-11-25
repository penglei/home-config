{ pkgs
, config
, ...
}:

let
  homeLocalBin = ".local/bin";
in {
  # https://ss64.com/osx/launchctl.html
  launchd.agents.skhd = {
    enable = true;

    config = {
      ProgramArguments = [ "${pkgs.skhd}/bin/skhd" ];
      EnvironmentVariables = {
        "PATH" = "${config.home.homeDirectory}/${homeLocalBin}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:";
        "SHELL" = "/bin/sh";
      };
      KeepAlive = true;
      RunAtLoad = true;
      ProcessType = "Interactive";
    };
  };
}


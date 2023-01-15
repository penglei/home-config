{ self,
  pkgs,
  system,
  home-manager
}:

let
  isDarwin = pkgs.lib.hasSuffix "darwin" system;
in
rec {
  hm = rec {
    base = {
      modules = [
        ./hm-modules/default.nix
        ./hm-modules/packages.nix
        ./hm-modules/zsh.nix
        ./hm-modules/fzf.nix
        ./hm-modules/git.nix
        ./hm-modules/tig.nix
        ./hm-modules/starship.nix
        ./hm-modules/neovim
        ./hm-modules/misc.nix
      ];
    };
    linux.modules = base.modules;
    darwin.modules = base.modules ++ [
      ./hm-modules/alacritty.nix
      ./hm-modules/darwin/settings.nix
      ./hm-modules/darwin/keybindings.nix
      ./hm-modules/darwin/app-aliases.nix
      ./hm-modules/darwin/skhd.nix
      ./hm-modules/darwin/yabai.nix
      ./hm-modules/darwin/gpg.nix
      ./hm-modules/darwin/rime-config.nix
      ./hm-modules/darwin/texlive.nix
      ./hm-modules/darwin/fonts.nix
    ];
  };

  hm-creator = {
    standalone = username: {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [{ home.username = username; }] ++
        (
          if isDarwin then 
            hm.darwin.modules ++ [{
              # Home Manager needs a bit of information about you and the paths it should manage.
              home.homeDirectory = "/Users/${username}";
            }]
          else
            hm.linux.modules ++ [{
              home.homeDirectory = "/home/${username}";
            }]
        );
      };
    };
  };
}

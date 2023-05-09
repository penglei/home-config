{ self,
  pkgs,
  system,
  home-manager,
  sops-nix
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
        ./hm-modules/zshvimode.nix
        ./hm-modules/git.nix
        ./hm-modules/tig.nix
        ./hm-modules/starship.nix
        ./hm-modules/neovim
        ./hm-modules/misc.nix
      ];
    };
    linux.modules = base.modules ++ [
      {zsh-vi-mode.enable = true;} #The compatibility of zsh-vi-mode and autopairs plugins is not good.
    ];
    darwin.modules = base.modules ++ [
      ./hm-modules/alacritty.nix
      sops-nix.homeManagerModule
      ./hm-modules/darwin/sops.nix
      ./hm-modules/darwin/settings.nix
      ./hm-modules/darwin/keybindings.nix
      ./hm-modules/darwin/app-aliases.nix
      ./hm-modules/darwin/skhd.nix
      ./hm-modules/darwin/yabai.nix
      ./hm-modules/darwin/sketchybar.nix
      ./hm-modules/darwin/gpg.nix
      ./hm-modules/darwin/ssh.nix
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

{ pkgs
, config
, ...
}:
let 
  lib = pkgs.lib;
  cfg = config.programs.zsh;
  zshcfg =
    let
      relToDotDir = file: (lib.optionalString (cfg.dotDir != null) (cfg.dotDir + "/")) + file;
    in {
      pluginsDir = if cfg.dotDir != null then relToDotDir "plugins" else ".zsh/plugins";
      plugins = cfg.plugins;
    };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "emacs";
    history = {
      size = 500000;
      save = 500000;
      path = "$HOME/.zsh_nix_history";
    };
    plugins = [
      {
        name = "omz-completion";
        file = "lib/completion.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "6df14641ac48b380c56e1c72aa86b57861fbfb70";
          sha256 = "sha256-bfaeszprKsaiPUhR8+QOtrLC57Dy3JOhXzntokkhLSI=";
        };
      }
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "sha256-PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
        };
      }
    ];
    envExtra = '''';
    initExtra = ''
      bindkey "^U" backward-kill-line
      bindkey -M menuselect '^[[Z' reverse-menu-complete

      setopt appendhistory
      setopt INC_APPEND_HISTORY  

      #unset PATH introduced by plugins
      ${lib.concatStrings (map (plugin: ''
        path[''${path[(I)$HOME/${zshcfg.pluginsDir}/${plugin.name}]}]=()
      '') zshcfg.plugins)}

      if [[ -f $HOME/.zshlocal ]]; then
        source $HOME/.zshlocal
      fi

    '';

    #e.g. debug performance: zmodload zsh/zprof
    initExtraFirst = ''
      if [[ -f $HOME/.zshlocal-first ]]; then
        source $HOME/.zshlocal-first
      fi
    '';
  };
}


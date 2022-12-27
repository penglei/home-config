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
        #file = "lib/completion.zsh";
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

      #unset PATH introduced by plugins
      ${lib.concatStrings (map (plugin: ''
        path[''${path[(I)$HOME/${zshcfg.pluginsDir}/${plugin.name}]}]=()
      '') zshcfg.plugins)}

      if [[ -f $HOME/.zshlocal ]]; then
        source $HOME/.zshlocal
      fi

      preman() {
        mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
      }
      xman() {
        open x-man-page://"$@"
      }
      #alias man='xman'
    '';

    #e.g. debug performance: zmodload zsh/zprof
    initExtraFirst = ''
      if [[ -f $HOME/.zshlocal-first ]]; then
        source $HOME/.zshlocal-first
      fi
    '';
  };
}


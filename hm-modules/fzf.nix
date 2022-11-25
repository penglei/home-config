{ pkgs
, config
, ...
}:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--height 90%" "--reverse" "--bind up:preview-up,down:preview-down" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
  };
}


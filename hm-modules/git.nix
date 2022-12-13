{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "penglei@ybyte.org";
    userName = "penglei";
    extraConfig = {
    };
    aliases = {
      # Prettier `git log`
      lg = "log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      # `git checkout` with fuzzy matching
      co = "!git for-each-ref --format='%(refname:short)' refs/heads | ${pkgs.fzf}/bin/fzf -0 | xargs git checkout";
      # `git restore --staged` with fuzzy matching
      rs = "!git diff --name-only --cached | ${pkgs.fzf}/bin/fzf -0 --multi | xargs git restore --staged";
      # Fetch a branch from a remote and rebase it on the current branch
      frb = "!git fetch $1 && git rebase $1/$2 && :";

      new = "checkout -b";
      rb = "rebase --interactive";
      last = "show HEAD";
      cim = "commit --amend";
      cimn = "commit --amend --no-edit";
      st = "status";
      br = "branch";
      ci = "commit";
      df = "diff";
      ps = "push";
      fp = "push --force";
      track = "checkout --track";
    };
    signing = {
      signByDefault = true;
      key = null; # Let the gpg agent handle it
    };

    extraConfig = {
      pager.branch = false;
      pull.rebase = true;
      init.defaultBranch = "main";
      push.default = "current";
    };

    # Prettier pager, adds syntax highlighting and line numbers
    delta = {
      enable = true;

      options = {
        navigate = true;
        line-numbers = true;
        conflictstyle = "diff3";
      };
    };

  };

  home.shellAliases = {
    ga = "git add";
    gaa = "git add --all";
    gapa = "git add --patch";
    gau = "git add --update";
    gav = "git add --verbose";

    gb = "git branch";
    gbl = "git blame -b -w";
    gbr = "git branch --remote";
    gbs = "git bisect";
    gbsb = "git bisect bad";
    gbsg = "git bisect good";
    gbsr = "git bisect reset";
    gbss = "git bisect start";

    gc = "git commit -v";
    "gc!" = "git commit -v --amend";
    "gcn!" = "git commit -v --no-edit --amend";
    gca = "git commit -v -a";
    "gca!" = "git commit -v -a --amend";

    gcb = "git checkout -b";
    gco = "git checkout";

    gd = "git diff";
    gdca = "git diff --cached";
    gdcw = "git diff --cached --word-diff";

    gl = "git pull";
    gp = "git push";
    gpu = "git push upstream";
    gst = "git status";

    #simple commit ammend
    gaucim = "gau;git commit --amend --no-edit";
  };

}


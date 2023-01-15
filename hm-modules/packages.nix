{ pkgs
, config
, ...
}:

{
  home.packages = with pkgs; [
      fortune coreutils-full binutils
      gnused gnugrep gnutar pstree tree watch findutils help2man ascii libiconv
      gnumake m4 libtool autoconf automake cmake ninja
      gnupg openssh sshpass htop rsync wget curl xz
      ripgrep fd jq yq-go fx bat
      git-lfs tig tmux fzf
      corkscrew socat
      pass pwgen sops age  #gopass #secret security
      hyperfine #performance test
      #ghostscript
      hexyl

      #rar
      #! rar is an unfree software, but we can't set allowunfree at this moment(2022-11-08)
      #! if we enable it, tedious commond `NIXPKGS_ALLOW_UNFREE=1 home-manager switch --impure`
      #! must be executed to switch home configuration.

      tree-sitter #generic ast parser
      nixfmt 
      koka
      go gotools
      #bear #Tool that generates a compilation database for clang tooling
      #ocaml opam ocamlPackages.sexp

      (python3.withPackages (ps: [ ps.numpy ps.pygments]))

      kustomize
      kubectl
      krew
      kubectl-kubectx
      kubectl-kubecm
      kubectl-nodeshell

      mynixcleaner 

      mongosh

      wireguard-tools

  ] ++ lib.optionals stdenvNoCC.isDarwin [
    kitty
    utm
    yabai
    jetbrains.pycharm-community
    netnewswire
    rectangle
    preview_open
    isabelle_app
    koodo-reader 
    bitwarden-desktop 
    spacelauncher
  ] ++ lib.optionals stdenvNoCC.isLinux [
  ];
}

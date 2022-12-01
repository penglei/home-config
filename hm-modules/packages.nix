{ pkgs
, config
, ...
}:

{
  home.packages = with pkgs; [
      fortune coreutils-full binutils
      gnugrep pstree tree watch help2man findutils
      gnumake m4 libtool autoconf automake cmake ninja
      gnupg openssh sshpass htop rsync wget
      ripgrep fd jq yq-go fx
      git-lfs tig neovim tmux fzf
      corkscrew socat
      pass pwgen sops age  #gopass #secret security
      hyperfine #performance test
      #ghostscript

      #rar
      #! rar is an unfree software, but we can't set allowunfree at this moment(2022-11-08)
      #! if we enable it, tedious commond `NIXPKGS_ALLOW_UNFREE=1 home-manager switch --impure`
      #! must be executed to switch home configuration.

      tree-sitter #generic ast parser
      nixfmt 
      deno
      koka
      go gotools protobuf
      bear #Tool that generates a compilation database for clang tooling
      #ocaml opam ocamlPackages.sexp

      (python3.withPackages (ps: [ ps.numpy ps.pygments]))

      kustomize
      kubectl
      krew
      kubectl-kubectx
      kubectl-kubecm
      kubectl-nodeshell

      mynixcleaner 

  ] ++ lib.optionals stdenvNoCC.isDarwin [
    utm
    jetbrains.pycharm-community
    netnewswire
    rectangle
    preview_open
    isabelle_app
  ] ++ lib.optionals stdenvNoCC.isLinux [
  ];
}

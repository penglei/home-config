{ pkgs
, config
, ...
}:

{
  home.packages = with pkgs; [
      fortune coreutils-full getopt
      gnused gnugrep gnutar pstree tree watch findutils help2man ascii libiconv
      gnumake m4 libtool autoconf automake cmake ninja
      #gnupg
      openssh openssl #openssl and openssh should be paired, don't use macOS default
      htop rsync wget curl xz zstd
      rhash
      ripgrep fd jq yq-go fx bat
      git-lfs tig tmux fzf
      asciinema #terminal recording
      socat
      sops age diceware pwgen
      ssh-tools
      hyperfine #performance test
      #ghostscript
      hexyl
      neofetch screenfetch #Information Tool
      #rar
      #! rar is an unfree software, but we can't set allowunfree at this moment(2022-11-08)
      #! if we enable it, tedious commond `NIXPKGS_ALLOW_UNFREE=1 home-manager switch --impure`
      #! must be executed to switch home configuration.

      emacs-nox
      helix #modern editor

      #tree-sitter #generic ast parser
      nixfmt-classic
      # koka
      go_1_21
      #bear #Tool that generates a compilation database for clang tooling
      #ocaml opam ocamlPackages.sexp

      watchexec

      # starlark-rust

      luarocks

      python3 #(python3.withPackages (ps: [ ps.numpy ps.pygments]))

      sqlite.out #for neovim telescope plugin

      nodejs_latest

      kustomize
      kubectl
      krew
      kubectl-kubectx
      kubectl-kubecm
      kubectl-nodeshell

      mynixcleaner 

      #mongosh

      wireguard-tools

      shiori

      trash-cli

  ] ++ lib.optionals stdenvNoCC.isDarwin [
    git-cliff
    gnupg #full with gui
    passage yubikey-manager yubico-piv-tool age-plugin-yubikey
    yabai 
    skhd
    keycastr
    sketchybar
    kitty
    utm
    graphviz
    presentation
    #jetbrains.pycharm-community
    netnewswire
    rectangle
    preview_open
    isabelle_app
    koodo-reader 
    #adobe-reader
    bitwarden-desktop 
    p7zip libarchive  #for decompress .pkg installer
    duti    #set default applications in alfred
    chez-racket
    alttab
    parinfer-rust #vim plugin for lisp brackets
    typst-prebuilt
    gotools
    k9s
  ] ++ lib.optionals stdenvNoCC.isLinux [
    #binutils #`ld` is not recommended installing globally.

    #(gnupg.override {
    #  enableMinimal = true;
    #  guiSupport = false;
    #})
    (gnupg.overrideAttrs (finalAttrs: previousAttrs: {
      postInstall = ''
        # add gpg2 symlink to make sure git does not break when signing commits
        ln -s $out/bin/gpg $out/bin/gpg2

        # Make libexec tools available in PATH
        for f in $out/libexec/; do
          if [[ "$(basename $f)" == "gpg-wks-client" ]]; then continue; fi
          ln -s $f $out/bin/$(basename $f)
        done
      '';
    }))
  ];
}

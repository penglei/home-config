{pkgs, ...}@inputs:
  
let
  kubectx = pkgs.kubectx;

  nodeshell = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "kubectl-node-shell";
    version = "1.6.0";

    src = pkgs.fetchFromGitHub {
      owner = "kvaps";
      repo = "kubectl-node-shell";
      rev = "v${version}";
      sha256 = "sha256-dAsNgvHgquXdb2HhLDYLk9IALneKkOxQxKb7BD90+1E=";
    };

    strictDeps = true;
    buildInputs = [ pkgs.bash ];

    installPhase = ''
      runHook preInstall

      install -m755 ./kubectl-node_shell -D $out/bin/kubectl-node_shell

      runHook postInstall
    '';
  };

  kubecm = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "kubectl-kubecm";
    version = "0.21.0";

    src = pkgs.fetchurl {
      url = "https://github.com/sunny0826/kubecm/releases/download/v0.21.0/kubecm_v0.21.0_Darwin_arm64.tar.gz";
      sha256 = "sha256-3HnUSlysTBFIfklYJ1ouUEF5iy/Jt9QQjF/KBWRu5DU=";
    };

    # Work around the "unpacker appears to have produced no directories"
    # case that happens when the archive doesn't have a subdirectory.
    setSourceRoot = "sourceRoot=`pwd`";

    buildInputs = [ pkgs.bash ];
    installPhase = ''
      runHook preInstall

      install -m755 ./kubecm -D $out/bin/kubectl-kubecm

      runHook postInstall
    '';
  };

  ctx_and_ns = pkgs.runCommand "kubectx-kubens" {} ''
    mkdir -p $out/bin
    ln -sf ${kubectx}/bin/kubectx $out/bin/kubectl-ctx
    ln -sf ${kubectx}/bin/kubens $out/bin/kubectl-ns
  '';

in [ nodeshell ctx_and_ns kubecm ]

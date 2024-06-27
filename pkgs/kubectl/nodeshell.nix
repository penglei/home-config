{ kubectx, stdenvNoCC, bash, fetchFromGitHub }:
stdenvNoCC.mkDerivation rec {
  pname = "kubectl-node-shell";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "kvaps";
    repo = "kubectl-node-shell";
    rev = "v${version}";
    sha256 = "sha256-dAsNgvHgquXdb2HhLDYLk9IALneKkOxQxKb7BD90+1E=";
  };

  strictDeps = true;
  buildInputs = [ bash ];

  installPhase = ''
    runHook preInstall

    install -m755 ./kubectl-node_shell -D $out/bin/kubectl-node_shell

    runHook postInstall
  '';
}

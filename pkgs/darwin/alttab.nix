{ lib
, fetchzip
, stdenvNoCC
}:

stdenvNoCC.mkDerivation rec {
  pname = "alttab";
  version = "6.57.0";

  src = fetchzip {
    url = "https://github.com/lwouis/alt-tab-macos/releases/download/v${version}/AltTab-${version}.zip";
    sha256 = "sha256-R4GDj72tkILGK5g1Z/iWaR7YLtiIlbEYWTuJxAMxCF8=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
    runHook postInstall
  '';

}

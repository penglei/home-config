{ lib
, fetchzip
, stdenvNoCC
}:

stdenvNoCC.mkDerivation rec {
  pname = "alttab";
  version = "6.55.0";

  src = fetchzip {
    url = "https://github.com/lwouis/alt-tab-macos/releases/download/v${version}/AltTab-${version}.zip";
    sha256 = "sha256-iEUE+OSNdsJpSsS6fG0OsOPKvSJ1YJ9d8GZ2/d9Mcs4=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
    runHook postInstall
  '';

}

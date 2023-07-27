{ lib
, fetchurl
, stdenvNoCC
, undmg
}:

stdenvNoCC.mkDerivation rec {
  pname = "koodo-reader";
  version = "1.5.6";

  src = fetchurl {
    url = "https://github.com/troyeguo/koodo-reader/releases/download/v${version}/Koodo-Reader-${version}-arm64.dmg";
    sha256 = "sha256-UwAEcnFLO/hbx2mfCYtz6vYB6cGNcbh5V0J80+jH1xU=";
  };

  sourceRoot = "Koodo Reader.app";

  nativeBuildInputs = [ undmg ];

  installPhase = ''
    runHook preInstall
    appdir="Koodo Reader.app"
    mkdir -p "$out/Applications/$appdir"
    cp -R . "$out/Applications/$appdir"
    runHook postInstall
  '';
}


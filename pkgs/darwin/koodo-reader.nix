{ lib
, fetchurl
, stdenvNoCC
, undmg
}:

stdenvNoCC.mkDerivation rec {
  pname = "koodo-reader";
  version = "1.5.1";

  src = fetchurl {
    url = "https://github.com/troyeguo/koodo-reader/releases/download/v${version}/Koodo-Reader-${version}-arm64.dmg";
    sha256 = "sha256-KZOQRuMkg14gVNJR6D8lKZLFG1pFrke+3rLdjXzYL6g=";
  };

  sourceRoot = "Koodo Reader.app";

  nativeBuildInputs = [ undmg ];

  installPhase = ''
    appdir="Koodo Reader.app"
    mkdir -p "$out/Applications/$appdir"
    cp -R . "$out/Applications/$appdir"
  '';
}


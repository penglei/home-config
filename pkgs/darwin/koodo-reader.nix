{ lib, fetchurl, stdenvNoCC, undmg }:

stdenvNoCC.mkDerivation rec {
  pname = "koodo-reader";
  version = "1.6.0";

  src = fetchurl {
    url =
      "https://github.com/troyeguo/koodo-reader/releases/download/v${version}/Koodo-Reader-${version}-arm64.dmg";
    sha256 = "sha256-94IqXWnusGfntfWxX7vqwQpF4Yos5MAEwNsjpVJI+AI=";
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


{ lib, fetchzip, stdenvNoCC }:

stdenvNoCC.mkDerivation rec {
  pname = "alttab";
  version = "6.64.0";

  src = fetchzip {
    url =
      "https://github.com/lwouis/alt-tab-macos/releases/download/v${version}/AltTab-${version}.zip";
    sha256 = "sha256-t9FfpA2zk5ycpSLcw1Z+9QpPCc6DA48LerrxSWflYx0=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
    runHook postInstall
  '';

}

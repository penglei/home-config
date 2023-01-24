{ lib
, fetchurl
, stdenvNoCC
, undmg
, p7zip
, libarchive
}:

stdenvNoCC.mkDerivation rec {
  pname = "adobe-reader";
  version = "2200320314";

  src = fetchurl {
    url = "https://ardownload2.adobe.com/pub/adobe/reader/mac/AcrobatDC/${version}/AcroRdrDC_${version}_MUI.dmg";
    sha256 = "sha256-ouy241PNFLXGBrS1yEfRdZA+c6/cXcZ0xJy06Pmreek=";
  };

  nativeBuildInputs = [ undmg p7zip libarchive];

  decompressScript = ../../scripts/adobe-pdf-reader-decompress;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications"
    7z x $src/AcroRdrDC_2200320314_MUI.pkg
    cd application.pkg
    cd application.pkg
    bsdtar -xf Payload
    mv "Adobe Acrobat Reader.app" "$out/Applications"

    cd $out/Applications/*.app/Contents && sh ${decompressScript}

    runHook postInstall
  '';
}


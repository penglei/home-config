{ lib, stdenv, fetchurl, libarchive, p7zip }:

stdenv.mkDerivation rec {
  pname = "presentation";
  version = "3.2.0";

  src = fetchurl {
    url =
      "http://iihm.imag.fr/blanch/software/osx-presentation/releases/osx-presentation-${version}.pkg";
    sha256 = "sha256-ff9Si2DdfKkan5L1u2T4BKvqleTw22hmgXtGdLrLsY8=";
  };

  dontBuild = true;
  nativeBuildInputs = [ libarchive p7zip ];

  unpackPhase = ''
    7z x $src
    bsdtar -xf Payload~
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R Présentation.app $out/Applications/
    runHook postInstall
  '';

  meta = with lib; {
    description = "A presentation tool for pdf slides for Mac OS X";
    homepage = "http://iihm.imag.fr/blanch/software/osx-presentation/";
    license = licenses.gpl3;
    platforms = platforms.darwin;
  };
}


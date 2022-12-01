{lib, stdenvNoCC, unzip, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "droidsans-fonts";
  version = "0.0.0";

  src = fetchurl {
    url = "https://www.fontsquirrel.com/fonts/download/droid-sans";
    #downloadToTemp = true;
    sha256 = "sha256-EZH44a9/mc9BGLdwthwcTamzCOh89s851tcx2MVTxSc=";

    #postFetch = ''
    #  mkdir -p $out/share/fonts/truetype
    #  install *.ttf $out/share/fonts/truetype
    #'';
  };

  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip $src
  '';

  #stripRoot = false;

  installPhase = ''
    runHook preInstall

    #find .

    mkdir -p $out/share/fonts/truetype
    install *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';
}

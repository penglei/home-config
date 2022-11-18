{ lib
, fetchzip
, stdenvNoCC
}:

stdenvNoCC.mkDerivation rec {
  pname = "utm";
  version = "6.1.1b1";

  src = fetchzip {
    url = "https://github.com/Ranchero-Software/NetNewsWire/releases/download/mac-${version}/NetNewsWire${version}.zip";
    stripRoot = false;
    sha256 = "sha256-6jXg4ClfVZh9HmanQ6mR+kSmN6Jg2KVfGd3bzwyNqlQ=";
  };

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = "It’s a free and open-source feed reader for macOS and iOS.";
    longDescription = ''
      It supports RSS, Atom, JSON Feed, and RSS-in-JSON formats."
    '';
    homepage = "https://netnewswire.com/";
    license = licenses.mit;
    platforms = platforms.darwin; # 10.15 is the minimum supported version.
  };
}

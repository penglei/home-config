{ lib
, fetchzip
, fetchurl
, stdenvNoCC
, stdenv
, undmg
}:

let
  netnewswire = stdenvNoCC.mkDerivation rec {
    pname = "netnewswire";
    version = "6.1.1b1";

    src = fetchzip {
      url = "https://github.com/Ranchero-Software/NetNewsWire/releases/download/mac-${version}/NetNewsWire${version}.zip";
      stripRoot = false;
      sha256 = "sha256-6jXg4ClfVZh9HmanQ6mR+kSmN6Jg2KVfGd3bzwyNqlQ=";
    };

    #sourceRoot = "."; # https://nixos.org/manual/nixpkgs/stable/#ssec-unpack-phase
    installPhase = ''
      runHook preInstall
      #find .
      #cat env-vars

      mkdir -p $out/Applications
      cp -r *.app $out/Applications
      runHook postInstall
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
  };

  rectangle = stdenv.mkDerivation rec {
    pname = "rectangle";
    version = "0.63";

    src = fetchurl {
      url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
      sha256 = "sha256-xgO9fqf8PX0SwEsMVef3pBiaLblTgo9ZNrqHUn0+JIg=";
    };

    sourceRoot = "Rectangle.app";

    nativeBuildInputs = [ undmg ];

    installPhase = ''
      mkdir -p $out/Applications/Rectangle.app
      cp -R . $out/Applications/Rectangle.app
    '';

    meta = with lib; {
      description = "Move and resize windows in macOS using keyboard shortcuts or snap areas";
      homepage = "https://rectangleapp.com/";
      sourceProvenance = with sourceTypes; [ binaryNativeCode ];
      platforms = platforms.darwin;
      maintainers = with maintainers; [ Enzime ];
      license = licenses.mit;
    };
  };

in [netnewswire rectangle]

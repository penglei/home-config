{ lib
, stdenvNoCC
, bash
, fetchurl
, ...
}:

let
  pname = "yabai";
  version = "6.0.1-p1";
in
{
  aarch64-darwin = stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/penglei/yabai/releases/download/v.6.0.1-p1/yabai-v6.0.1.tar.gz";
      sha256 = "sha256-XeeMylW+lZdqzOhWrGJcsl6pcfRQ8gQBXWl+kBOdv/o=";
    };

    buildInputs = [ bash ];
    installPhase = ''
      runHook preInstall

      install -m755 ./bin/* -Dt $out/bin

      runHook postInstall
    '';
  };

}.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported platform ${stdenvNoCC.hostPlatform.system}")

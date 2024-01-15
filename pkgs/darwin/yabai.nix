{ lib
, stdenvNoCC
, bash
, fetchurl
, ...
}:

let
  pname = "yabai";
  version = "6.0.6-p1";
in
{
  aarch64-darwin = stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/penglei/yabai/releases/download/v6.0.6-p1/yabai-v6.0.6.tar.gz";
      sha256 = "sha256-a4XV9vWku4mHqYL1JgL2j9ebNAsumP9mv+XqDz692/8=";
    };

    buildInputs = [ bash ];
    installPhase = ''
      runHook preInstall

      install -m755 ./bin/* -Dt $out/bin

      runHook postInstall
    '';
  };

}.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported platform ${stdenvNoCC.hostPlatform.system}")

{ lib
, stdenvNoCC
, bash
, fetchurl
, ...
}:

let
  pname = "yabai";
  version = "6.0.2-p1";
in
{
  aarch64-darwin = stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/penglei/yabai/files/13763514/yabai-v6.0.2.tar.gz";
      sha256 = "sha256-A5o+QdisboLF56qNyaLwEUj3zQdnbeoZxr/+5FDADK0=";
    };

    buildInputs = [ bash ];
    installPhase = ''
      runHook preInstall

      install -m755 ./bin/* -Dt $out/bin

      runHook postInstall
    '';
  };

}.${stdenvNoCC.hostPlatform.system} or (throw "Unsupported platform ${stdenvNoCC.hostPlatform.system}")

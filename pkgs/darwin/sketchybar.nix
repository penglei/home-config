{ lib, stdenv, fetchFromGitHub, Carbon, Cocoa, CoreWLAN, DisplayServices, SkyLight, MediaRemote}:

let
  inherit (stdenv.hostPlatform) system;
  target = {
    "aarch64-darwin" = "arm64";
    "x86_64-darwin" = "x86";
  }.${system} or (throw "Unsupported system: ${system}");

in

stdenv.mkDerivation rec {
  pname = "sketchybar";
  version = "master"; #>2.15.2

  src = fetchFromGitHub {
    owner = "FelixKratz";
    repo = "SketchyBar";
    rev = "dc59f2e36adca6cc04d8024a35e57615ff50efb3";
    sha256 = "sha256-vVtS4q1uAM/po2RMcOUsEqI+gyjtdrHCDRpmIJBDqpM=";
  };

  buildInputs = [ Carbon Cocoa CoreWLAN DisplayServices SkyLight MediaRemote];

  makeFlags = [
    target
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./bin/sketchybar $out/bin/sketchybar
  '';

  meta = with lib; {
    description = "A highly customizable macOS status bar replacement";
    homepage = "https://github.com/FelixKratz/SketchyBar";
    platforms = platforms.darwin;
    maintainers = [ maintainers.azuwis ];
    license = licenses.gpl3;
  };
}

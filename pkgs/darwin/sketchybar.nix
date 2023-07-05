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
    rev = "61eacaeb450deec43b3cdfc510541eaea3165b5d";
    sha256 = "sha256-13wc+1IgplB+L0j1AbBr/MUjEo4W38ZgJwrAhbdOroE=";
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

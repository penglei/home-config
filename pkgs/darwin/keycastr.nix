{ lib
, fetchzip
, stdenvNoCC
}:

stdenvNoCC.mkDerivation rec {
  pname = "keycastr";
  version = "0.9.13";

  src = fetchzip {
    url = "https://github.com/keycastr/keycastr/releases/download/v${version}/KeyCastr.app.zip";
    stripRoot = false;
    sha256 = "sha256-MuImZXfy2By+JyRbGZDegzKpxu21D/4ATgKs+wK3uRQ=";
  };

  #sourceRoot = "."; # https://nixos.org/manual/nixpkgs/stable/#ssec-unpack-phase
  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r *.app $out/Applications
    runHook postInstall
  '';

  meta = with lib; {
    description = "KeyCastr, an open source keystroke visualizer.";
    longDescription = ''
      KeyCastr enables you to share your keystrokes when creating screencasts, presenting,
      or collaborating with others. You can choose to display all keystrokes or command
      keys only, and there is also an option to include mouse clicks.
    '';
    homepage = "https://github.com/keycastr/keycastr";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}


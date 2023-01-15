{ fetchurl, makeWrapper }:

{
  override = finalAttrs: previousAttrs: rec {
    version = "4.1.5";
    src = fetchurl {
      url = "https://github.com/utmapp/UTM/releases/download/v${version}/UTM.dmg";
      sha256 = "sha256-YOmTf50UUvvh4noWnmV6WsoWSua0tpWTgLTg+Cdr3bQ=";
    };

    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [makeWrapper];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/Applications
      cp -r *.app $out/Applications
      runHook postInstall
    '';

    #Wrap the utm command tool. the linked utmctl don't work, which rely on directory structure.
    postInstall = ''
      mkdir -p $out/bin
      makeWrapper $out/Applications/UTM.app/Contents/MacOS/utmctl $out/bin/utmctl
    '';
  };
}

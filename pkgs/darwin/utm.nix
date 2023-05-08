{ fetchurl, makeWrapper }:

{
  override = finalAttrs: previousAttrs: rec {
    version = "4.2.5";
    src = fetchurl {
      url = "https://github.com/utmapp/UTM/releases/download/v${version}/UTM.dmg";
      sha256 = "sha256-T3TA+CwddNtUL80xASRCSczGA2LLTwPEA2+jnc9m6jY=";
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

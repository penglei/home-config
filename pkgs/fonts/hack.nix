{lib, nerd-font-patcher, stdenvNoCC, unzip, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "hack-font";
  version = "v3.003";

  src = fetchzip {
    url = "https://github.com/source-foundry/Hack/releases/download/${version}/Hack-${version}-ttf.zip";
    sha256 = "sha256-SxF4kYp9aL/9L9EUniquFadzWt/+PcvhUQOIOvCrFRM=";

    #postFetch = ''
    #  mkdir -p $out/share/fonts/truetype
    #  install *.ttf $out/share/fonts/truetype
    #'';
  };

  nativeBuildInputs = [ nerd-font-patcher ];

  installPhase = ''
    runHook preInstall


    mkdir -p $out/share/fonts/truetype

    for f in $(ls *.ttf); do
      nerd-font-patcher "$f"  \
        --fontawesome  \
        --fontawesomeextension \
        --fontlogos \
        --octicons \
        --codicons \
        --powersymbols \
        --pomicons \
        --material \
        --weather \
        -out $out/tmp
      mv $out/tmp/*.ttf $out/share/fonts/truetype/$f
    done
    
    rm -rf $out/tmp

    runHook postInstall
  '';
}


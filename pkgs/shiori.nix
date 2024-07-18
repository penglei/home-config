{ lib, stdenvNoCC, pkgs, fetchurl, bash, ... }:

# pkgs.buildGoModule rec {
#   pname = "shiori";
#   version = "1.5.4";
#   # modRoot = "";

#   src = pkgs.fetchFromGitHub {
#     owner = "go-shiori";
#     repo = "shiori";
#     rev = "v${version}";
#     sha256 = "sha256-QZTYhRz65VLs3Ytv0k8ptfeQ/36M2VBXFaD9zhQXDh8=";
#   };
#   vendorHash = "sha256-8aiaG2ry/XXsosbrLBmwnjbwIhbKMdM6WHae07MG7WI=";
#   doCheck = false;
# }

stdenvNoCC.mkDerivation rec {
  pname = "shiori";
  version = "1.7.0";

  src = fetchurl {
    url =
      "https://github.com/go-shiori/shiori/releases/download/v${version}/shiori_Darwin_aarch64_${version}.tar.gz";
    sha256 = "sha256-w5Y1zgd6yAEzQ8TPisikxxv0SoDaKSqRPYSeqmcSwBE=";
  };

  # Work around the "unpacker appears to have produced no directories"
  # case that happens when the archive doesn't have a subdirectory.
  setSourceRoot = "sourceRoot=`pwd`";

  buildInputs = [ bash ];
  installPhase = ''
    runHook preInstall

    install -m755 ./shiori -D $out/bin/shiori

    runHook postInstall
  '';
  meta = with lib; { platforms = platforms.darwin; };
}


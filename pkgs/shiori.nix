{ pkgs, ... }:

pkgs.buildGoModule rec {
  pname = "shiori";
  version = "1.5.4";
  # modRoot = "";

  src = pkgs.fetchFromGitHub {
    owner = "go-shiori";
    repo = "shiori";
    rev = "v${version}";
    sha256 = "sha256-QZTYhRz65VLs3Ytv0k8ptfeQ/36M2VBXFaD9zhQXDh8=";
  };
  vendorHash = "sha256-8aiaG2ry/XXsosbrLBmwnjbwIhbKMdM6WHae07MG7WI=";
  doCheck = false;
}

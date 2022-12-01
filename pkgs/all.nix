final: prev:
let
  pkgs = final;
in
with pkgs;
{
  mynixcleaner = callPackage ./nix-cleaner.nix {};

  nerdfonts = (prev.nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" "DroidSansMono" "Monoid"]; });

  kubectl-kubectx = callPackage ./kubectl/kubectx.nix {};
  kubectl-kubecm = callPackage ./kubectl/kubecm.nix {};
  kubectl-nodeshell = callPackage ./kubectl/nodeshell.nix {};


  utm = (prev.utm.overrideAttrs (finalAttrs: previousAttrs: rec {
    version = "4.1.0";
    src = fetchurl {
      url = "https://github.com/utmapp/UTM/releases/download/v${version}/UTM.dmg";
      sha256 = "sha256-GvwlmWTQTEvJqMBZHPT+TqENkEaO+l7uwf0shDGn1rE=";
    };
  }));

  netnewswire = callPackage ./darwin/netnewswire.nix {};
  rectangle = callPackage ./darwin/rectangle.nix {};

  droidsans_fonts = callPackage ./fonts/droidsans.nix {};

  preview_open = callPackage ./darwin/preview.nix {};
}

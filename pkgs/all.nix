final: prev:
let
  pkgs = final;
in
with pkgs;
{
  createScript = callPackage ./createscript.nix {};

  nerdfonts = (prev.nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" "DroidSansMono" "Monoid"]; });

  kubectl-kubectx = callPackage ./kubectl/kubectx.nix {};
  kubectl-kubecm = callPackage ./kubectl/kubecm.nix {};
  kubectl-nodeshell = callPackage ./kubectl/nodeshell.nix {};

  utm = (prev.utm.overrideAttrs (finalAttrs: previousAttrs: rec {
    version = "4.1.2";
    src = fetchurl {
      url = "https://github.com/utmapp/UTM/releases/download/v${version}/UTM.dmg";
      sha256 = "sha256-OtQFHsDdkkO/NinGC1rF7ynxLxsr3m7TvVU9vBkAW9w=";
    };
  }));

  netnewswire = callPackage ./darwin/netnewswire.nix {};
  rectangle = callPackage ./darwin/rectangle.nix {};

  droidsans_fonts = callPackage ./fonts/droidsans.nix {};

  preview_open = callPackage ./darwin/preview.nix {};

  isabelle_app = callPackage ./darwin/isabelle.nix {};

  mynixcleaner = callPackage ./nix-cleaner.nix {};

  nix-direnv = callPackage ./nix-direnv {};

  mongosh = callPackage ./mongosh {};

  koodo-reader = callPackage ./darwin/koodo-reader.nix {};

  alacritty = callPackage ./alacritty {
    inherit (darwin.apple_sdk.frameworks) AppKit CoreGraphics CoreServices CoreText Foundation OpenGL;
  };
}

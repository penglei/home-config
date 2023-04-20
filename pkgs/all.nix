final: prev:
let
  pkgs = final;
in
with pkgs;
{
  createScript = callPackage ./createscript.nix {};

  kubectl-kubectx = callPackage ./kubectl/kubectx.nix {};
  kubectl-kubecm = callPackage ./kubectl/kubecm.nix {};
  kubectl-nodeshell = callPackage ./kubectl/nodeshell.nix {};

  utm = (prev.utm.overrideAttrs (import ./darwin/utm.nix {inherit fetchurl makeWrapper;}).override);

  netnewswire = callPackage ./darwin/netnewswire.nix {};
  rectangle = callPackage ./darwin/rectangle.nix {};

  droidsans_fonts = callPackage ./fonts/droidsans.nix {};
  hack-nerd-font = callPackage ./fonts/hack.nix {};
  apple-sfmono-font = callPackage ./fonts/sfmono.nix {};
  apple-sfmono-nerd-font = callPackage ./fonts/sfmono-nerd.nix {};

  preview_open = callPackage ./darwin/preview.nix {};

  isabelle_app = callPackage ./darwin/isabelle.nix {};

  mynixcleaner = callPackage ./nix-cleaner.nix {};

  nix-direnv = callPackage ./nix-direnv {};

  mongosh = callPackage ./mongosh {};

  koodo-reader = callPackage ./darwin/koodo-reader.nix {};

  alacritty-custom = callPackage ./alacritty {
    inherit (darwin.apple_sdk.frameworks) AppKit CoreGraphics CoreServices CoreText Foundation OpenGL;
  };

  bitwarden-desktop = callPackage ./darwin/bitwarden-desktop.nix {};
  spacelauncher = callPackage ./darwin/spacelauncher.nix {};
  spacebar = callPackage ./darwin/spacebar.nix {
    inherit (darwin.apple_sdk.frameworks) Carbon Cocoa ScriptingBridge SkyLight;
  };

  sketchybar = callPackage ./darwin/sketchybar.nix {
    inherit (darwin.apple_sdk.frameworks) Carbon Cocoa SkyLight DisplayServices;
  };
  screenfetch = callPackage ./screenfetch {};
  presentation = callPackage ./darwin/presentation.nix {};
  adobe-reader = callPackage ./darwin/adobe-reader.nix {};
  keycastr = callPackage ./darwin/keycastr.nix {};
  alttab = callPackage ./darwin/alttab.nix {};
  yabai = darwin.apple_sdk_11_0.callPackage ./darwin/yabai.nix {
    inherit (darwin.apple_sdk_11_0.frameworks) SkyLight Cocoa Carbon ScriptingBridge;
  };
}

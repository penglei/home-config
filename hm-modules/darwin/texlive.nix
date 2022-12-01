{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of
      textpos changepage minted fvextra
      ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });
in
{ # home-manager
  home.packages = with pkgs; [
    tex
  ];

  xdg.configFile."fontconfig/conf.d/20-os-fonts.conf".text =
  ''
  <?xml version='1.0'?>
  <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
  <fontconfig>
    <dir>/System/Library/Fonts</dir>
    <dir>/System/Library/Fonts/Supplemental</dir>
    <dir>/Library/Fonts</dir>
    <dir>/System/Library/PrivateFrameworks/FontServices.framework/Versions/A/Resources/Fonts/Subsets</dir>
  </fontconfig>
  '';
}

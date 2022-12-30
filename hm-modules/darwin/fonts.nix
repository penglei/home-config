{pkgs, ...}:
{
  home.packages = with pkgs; [
      fontconfig
      nerdfonts
      noto-fonts-emoji
      (iosevka-bin.override { variant = "slab"; }) sarasa-gothic
      dejavu_fonts
      twemoji-color-font
      #twitter-color-emoji

      #custom
      droidsans_fonts 
      hack-font
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

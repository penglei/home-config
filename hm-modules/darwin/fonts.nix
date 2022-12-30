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

  #texlive 需要的一些字体如SongTi需要通过fontconfig在系统字体目录中查找. MacOS不同版本可能这些目录可能会变..
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

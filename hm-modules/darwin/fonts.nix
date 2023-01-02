{pkgs, ...}:
{
  home.packages = with pkgs; [
      fontconfig

      #{--coding font
      (nerdfonts.override { fonts = [
        #prefer ** (<most width>, <ligatures>)
        "FiraCode" 

        #prefer ** (<most narrow>, <ligatures>)
        "JetBrainsMono"

        #prefer *** (<narrow>, <no-ligatures>)
        "DejaVuSansMono"

        #prefer *** (<narrow>, <no-ligatures>)
        #derived from DejaVuSansMono
        "Hack"

        "DroidSansMono"
        "Monoid"
      ]; })

      #^custom Hack
      #some symbols not exist which are needed by neovim NvChad(😣).
      #hack-nerd-font

      #jetbrains-mono
      #--}

      apple-sfmono-font

      (iosevka-bin.override { variant = "slab"; }) sarasa-gothic

      noto-fonts-emoji

      twemoji-color-font

      dejavu_fonts

      #^custom
      droidsans_fonts 
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

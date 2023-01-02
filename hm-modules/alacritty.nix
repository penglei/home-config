{ pkgs
, lib
, config
, ...
}:

let
  fontfamily = "FiraCode Nerd Font Mono";
  #font:
  #  normal:
  #    family: FiraCode Nerd Font Mono
  #
  ##family: FiraCode Nerd Font
  ##family: FiraCode Nerd Font Mono
  ##
  ##family: JetBrainsMono Nerd Font
  ##family: JetBrainsMono Nerd Font Mono
  ##
  ##family: Hack Nerd Font
  ##family: Hack Nerd Font Mono #(↑ 没区别)
  ##
  ##family: DejaVuSansMono Nerd Font
  ##family: DejaVuSansMono Nerd Font Mono #(↑ 没区别)

  userlocalconfigfile = "~/.config/alacritty/userlocal.yml";
in
{
  home.activation.writerMutableAllcrittyConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    touch ${userlocalconfigfile}
    ${pkgs.yq-go}/bin/yq -i '.font.normal.family = "${fontfamily}"' ${userlocalconfigfile}
    ${pkgs.yq-go}/bin/yq -i '.font.normal.style = "Light"' ${userlocalconfigfile}
  '';
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ userlocalconfigfile ];
      window = {
        decorations = "buttonless";
        opacity = 1.0;
        startup_mode = "Maximized";
        title = "😄";
        dynamic_title = false;
      };
      font = {
        normal = {
          ##config in userlocal.yml
          #family = "Hack Nerd Font" # "FiraCode Nerd Font Mono" "DejaVuSansMono Nerd Font Mono" 
          #style = "Light"; #Light Regular Bold

        };
        size = 18.0;
      };
      key_bindings = [
        { key = "Space"; mods = "Control"; mode = "~Search"; action = "ToggleViMode"; }
        { key = "T"; mods = "Command"; action = "CreateNewWindow"; }
        { key = "F"; mods = "Alt"; chars = "\\ef"; }
        { key = "B"; mods = "Alt"; chars = "\\eb"; }
        { key = "H"; mods = "Alt"; chars = "\\eb"; }
        { key = "D"; mods = "Alt"; chars = "\\ed"; }
        { key = "Q"; mods = "Alt"; chars = "\\eq"; }
        { key = "I"; mods = "Alt"; chars = "\\ei"; }   #nvim toggle float terminal
        { key = "V"; mods = "Alt"; chars = "\\ev"; }   #nvim toggle vertial terminal
        { key = "H"; mods = "Alt"; chars = "\\eh"; }   #nvim toggle horizontal terminal
      ];

      hints = {
        enabled = [
          {
            regex = "file:///nix/store/.+ghc.+-doc/.+/html/[^)\\n\\r\\t ]+";
            command = {
              program = "/Users/penglei/.local/bin/open-haskell-doc";
            };
            hyperlinks = true; 
            post_processing = true;
            mouse = { enabled = true; mods = "None"; };
            binding = { key = "U"; mods = "Control|Shift"; };
          }
          {
            regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+";
            command = {
              program = "open";
              args = [ "-n" "-a" "Google Chrome" "--args" ];
            };
            hyperlinks = true; 
            post_processing = true;
            mouse = { enabled = true; mods = "None"; };
            binding = { key = "U"; mods = "Control|Shift"; };
          }
        ];
      };
    };
  };
}

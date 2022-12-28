{ pkgs
, config
, ...
}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "buttonless";
        opacity = 1.0;
        startup_mode = "Maximized";
        title = "😄";
        dynamic_title = false;
      };
      font = {
        normal = {
          family = "DejaVuSansMono Nerd Font Mono";
        };
        size = 18.0;
      };
      key_bindings = [
        { key = "Space"; mods = "Control"; mode = "~Search"; action = "ToggleViMode"; }
        { key = "T"; mods = "Command"; action = "CreateNewWindow"; }
        { key = "F"; mods = "Alt"; chars = "\\x1bf"; }
        { key = "B"; mods = "Alt"; chars = "\\x1bb"; }
        { key = "H"; mods = "Alt"; chars = "\\x1bb"; }
        { key = "D"; mods = "Alt"; chars = "\\x1bd"; }
        { key = "Q"; mods = "Alt"; chars = "\\x1bq"; }
        { key = "I"; mods = "Alt"; chars = "\\x1bi"; }   #nvim toggle float terminal
        { key = "V"; mods = "Alt"; chars = "\\x1bv"; }   #nvim toggle vertial terminal
        { key = "H"; mods = "Alt"; chars = "\\x1bh"; }   #nvim toggle horizontal terminal
      ];

      hints = {
        enabled = [
          {
            regex = "file:///nix/store/.+ghc.+-doc/.+/html/[^)\\n\\r]+";
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

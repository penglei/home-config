{ ... }:
{
  targets.darwin.keybindings = {
    "~f" = "moveWordForward:";
    "~b" = "moveWordBackward:";
    #"~<" = "moveToBeginningOfDocument:";
	  #"~>" = "moveToEndOfDocument:";
    "~d" = "()";
    "~q" = "()";
    "~i" = "noop:";  # same as '()'
    "~v" = "()";
    "~h" = "()";
  };
}


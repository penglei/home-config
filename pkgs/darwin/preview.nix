
{writeShellApplication}: 

writeShellApplication {
  name = "preview";
  text = ''
    exec open -a Preview.app "$@";
  '';
}



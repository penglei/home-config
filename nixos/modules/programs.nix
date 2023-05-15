{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [git ripgrep]; #merge syntatics
}

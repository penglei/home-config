{ pkgs
, config
, ...
}:

{
  home.file.".ssh/authorized_keys".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExc0Q5m5Sbsw3FVwgN42ch4uCexx6GiR7sce3Q1Coww
  '';
}

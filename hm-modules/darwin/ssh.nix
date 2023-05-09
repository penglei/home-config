{ pkgs
, config
, lib
, ...
}:

let
    key = (import ../../config.nix).ssh.authorized_key;
in
{
  # home.file.".ssh/authorized_keys".text = key;

  home.activation.SetupAuthorizedSSHKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''

    $DRY_RUN_CMD  echo -n "${key}" > $HOME/.ssh/authorized_keys

  '';

  home.file.".ssh/config".text = ''
    Host *
      ServerAliveInterval 120
      TCPKeepAlive no
      ForwardAgent yes
      StrictHostKeyChecking no

    Include config.d/*

  '';

  home.file.".ssh/config.d/utm-vm".text = ''
    Host utm-vm
        Hostname 192.168.65.5
  '';
}

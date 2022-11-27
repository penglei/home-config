{ pkgs
, config
, ...
}:

{
  programs.gpg = {
    enable = true;
    settings = {
      # https://gist.github.com/graffen/37eaa2332ee7e584bfda
      "no-emit-version" = true;
      "no-comments" = true;
      "use-agent" = true;
      "with-fingerprint" = true;
      "with-keygrip" = true;
      #"show-unusable-subkeys" = true;
      "keyid-format" = "long";
      
      "list-options" = "show-uid-validity";

      # list of personal digest preferences. When multiple digests are supported by
      # all recipients, choose the strongest one
      "personal-cipher-preferences"  = "AES256 TWOFISH AES192 AES";
      
      # list of personal digest preferences. When multiple ciphers are supported by
      # all recipients, choose the strongest one
      "personal-digest-preferences" = "SHA512 SHA384 SHA256 SHA224";
      
      # message digest algorithm used when signing a key
      "cert-digest-algo" = "SHA512";
      
      # This preference list is used for new keys and becomes the default for "setpref" in the edit menu
      "default-preference-list" = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
    };
  };
  programs.zsh.initExtra = ''
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK="$(gpgconf --homedir ${config.programs.gpg.homedir} --list-dirs agent-ssh-socket)"
  '';

  home.file."${config.programs.gpg.homedir}/gpg-agent.conf".text = ''enable-ssh-support'';
}

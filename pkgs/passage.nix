{ lib
, stdenv
, fetchFromGitHub
, makeBinaryWrapper
, age
, qrencode
, git
# Used to pretty-print list of all stored passwords, but is not needed to fetch
# or store password by its name. Most users would want this dependency.
, tree
, getopt
}:

let 
  srcDownloads = lib.listToAttrs [
    {
      name = "aarch64-darwin";
      value = fetchFromGitHub {
        owner = "penglei";
        repo = "passage";
        rev = "6f710a04a4e23c3762c711366c1fcf6b35a112a6";
        sha256 = "sha256-Z6cxOm5KqyQJ1Obz87PpL/Vg1dJ+8mU0+5T8EdlVhgM=";
      };
    }
  ];
in
stdenv.mkDerivation {
  pname = "passage";
  version = "master-2022-12-31";

  # src = ./passage-dev; #no git
  src = srcDownloads.${stdenv.system};

  nativeBuildInputs = [ makeBinaryWrapper ];

  extraPath = lib.makeBinPath [ age git qrencode tree getopt ];

  # Using $0 is bad, it causes --help to mention ".passage-wrapped".
  postInstall = ''
    substituteInPlace $out/bin/passage --replace 'PROGRAM="''${0##*/}"' 'PROGRAM=passage'
    wrapProgram $out/bin/passage --prefix PATH : $extraPath --argv0 $pname
  '';

  installFlags = [ "PREFIX=$(out)" "WITH_ALLCOMP=yes" ];

  meta = with lib; {
    description = "Stores, retrieves, generates, and synchronizes passwords securely";
    homepage    = "https://github.com/FiloSottile/passage";
    license     = licenses.gpl2Plus;
    platforms   = platforms.unix;

    longDescription = ''
      passage is a fork of password-store (https://www.passwordstore.org) that uses
      age (https://age-encryption.org) as a backend instead of GnuPG.

      It keeps passwords inside age(1) encrypted files inside a simple
      directory tree and provides a series of commands for manipulating the
      password store, allowing the user to add, remove, edit and synchronize
      passwords.
    '';
  };
}


{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "zsh-vi-mode";
  version = "master";

  src = fetchFromGitHub {
    owner = "jeffreytse";
    repo = pname;
    rev = "2ca0cf64b2f8f4004ab329bb2e3f87a7bfd21f02";
    hash = "sha256-B4tecnCyuPE2QrNQv8dv3NPcmQ4IlJqiq+5GZMF8kE4=";
  };

  strictDeps = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/${pname}
    cp *.zsh $out/share/${pname}/
  '';

  meta = with lib; {
    homepage = "https://github.com/jeffreytse/zsh-vi-mode";
    license = licenses.mit;
    description = "A better and friendly vi(vim) mode plugin for ZSH.";
    maintainers = with maintainers; [ kyleondy ];
  };
}


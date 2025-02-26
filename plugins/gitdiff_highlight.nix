{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "gitdiff_highlight";

  passthru.targetDir = "lite-xl/plugins/${name}";

  src = pkgs.fetchFromGitHub {
    owner = "vincens2005";
    repo = "lite-xl-gitdiff-highlight";
    rev = "master";
    sha256 = "sha256-qeBy4+7l+YM0buAWYQZOvhco6f3kwKuQxuh1dUBXX74=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp -r $src/* $out/share/${name}
  '';
}

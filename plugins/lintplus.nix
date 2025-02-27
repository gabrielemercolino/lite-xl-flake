{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "lintplus";

  passthru.targetDir = "lite-xl/plugins/${name}";

  src = pkgs.fetchFromGitHub {
    owner = "liquidev";
    repo = "lintplus";
    rev = "master";
    sha256 = "sha256-CRfv6eFY4dZ9J937NHK+HE+e7fLkCH+cE6MQgn2OxNg=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp -r $src/* $out/share/${name}
  '';
}

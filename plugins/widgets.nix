{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "lite-xl-widgets";

  passthru.targetDir = "lite-xl/libraries/widget";

  src = pkgs.fetchFromGitHub {
    owner = "lite-xl";
    repo = "lite-xl-widgets";
    rev = "master";
    sha256 = "sha256-6oOxJPRzDwpFh9wp20WocT3gB0wQpA3LI4IarF0hMfw=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp -r $src/* $out/share/${name}
  '';
}

{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "code-plus";

  passthru.targetDir = "lite-xl/plugins/${name}";

  src = pkgs.fetchFromGitHub {
    owner = "lite-xl";
    repo = "console";
    rev = "master";
    sha256 = "sha256-ihU5du2+oEoltcDey88yKWAZxELXMaOZg7xSddkFEls=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp -r $src/* $out/share/${name}
  '';
}

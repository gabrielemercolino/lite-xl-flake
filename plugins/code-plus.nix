{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "code-plus";

  passthru.targetDir = "lite-xl/plugins/${name}";
  dontUnpack = true;

  src = pkgs.fetchFromGitHub {
    owner = "chqs-git";
    repo = "code-plus";
    rev = "main";
    sha256 = "sha256-SKwvCdmCoAvRZroi5y4nNKsEBa9BLhI81STyP0rbjJc=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp -r $src/* $out/share/${name}
  '';
}

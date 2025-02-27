{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "bracketmatch";

  passthru.targetDir = "lite-xl/plugins/${name}";
  dontUnpack = true;

  src = pkgs.fetchurl {
    url = "https://github.com/lite-xl/lite-xl-plugins/blob/master/plugins/bracketmatch.lua?raw=1";
    sha256 = "sha256-6BSQoCgNune0pFtQZiqW0rU2kwZImim5qyNFsa029eQ=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp $src $out/share/${name}/init.lua
  '';
}

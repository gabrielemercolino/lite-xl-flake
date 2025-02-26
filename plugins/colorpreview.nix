{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "colorpreview";

  passthru.targetDir = "lite-xl/plugins/${name}";
  dontUnpack = true;

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/colorpreview.lua";
    sha256 = "sha256-d7cLFPllpwLKWIek1zO88KNMb/aBjuZE2jWoOXziZe8=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp $src $out/share/${name}/init.lua
  '';
}

{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "autoinsert";

  passthru.targetDir = "lite-xl/plugins/${name}";
  dontUnpack = true;

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/autoinsert.lua";
    sha256 = "sha256-qbWsR0L3Fb3pVVe9BQ40NffUpiY7IXXxJ6J1nF//WBk=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp $src $out/share/${name}/init.lua
  '';
}

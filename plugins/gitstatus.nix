{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "gitstatus";

  passthru.targetDir = "lite-xl/plugins/${name}";
  dontUnpack = true;

  src = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/gitstatus.lua";
    sha256 = "sha256-i4ZSjFXcqMGsABJac4movtnDY6BZ0m7xa1cnAa3VSoE=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp $src $out/share/${name}/init.lua
  '';
}

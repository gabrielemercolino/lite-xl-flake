{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "lite-xl-lsp";

  passthru.targetDir = "lite-xl/plugins/lsp";

  src = pkgs.fetchFromGitHub {
    owner = "lite-xl";
    repo = "lite-xl-lsp";
    rev = "master";
    sha256 = "sha256-42F8O7N7l4vQA8D+HgZNokknbWn/U7dv33GDXJ0yrPs=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp $src $out/share/${name}/init.lua
  '';
}

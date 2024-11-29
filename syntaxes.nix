{ pkgs, stdenv }:

let
  mkSyntax =
    {
      name,
      src,
      postInstall ? "",
    }:
    stdenv.mkDerivation rec {
      inherit name src postInstall;
      dontUnpack = true;

      installPhase = ''
        mkdir -p $out/share/
        cp $src $out/share/${name}_syntax.lua

        runHook postInstall
      '';
    };
in
[
  (mkSyntax {
    name = "nix";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/language_nix.lua";
      sha256 = "sha256-IhZx5Gu2EZkbJUcpGhdtaZAJILH1HB+HZHLSxh+9Rg8=";
    };
  })
  (mkSyntax {
    name = "sh";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/language_sh.lua";
      sha256 = "sha256-+ie/XBYu8ok5xDLK8pKBE3BDLDx3FWm+wMtIjtQmRms=";
    };
  })
]

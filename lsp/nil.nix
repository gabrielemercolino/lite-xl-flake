{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "nillsp";
  src = null;

  phases = ["installPhase"];

  installPhase = ''
    mkdir -p $out/share

    echo '
    -- mod-version:3
    local lspconfig = require "plugins.lsp.config"

    lspconfig.${name}.setup {
      command = { "${pkgs.nil}/bin/nil" }
    }
    ' > $out/share/${name}_lsp.lua
  '';
}

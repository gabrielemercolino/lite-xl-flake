{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "rust_analyzer";
  src = null;

  phases = ["installPhase"];

  installPhase = ''
    mkdir -p $out/share

    echo '
    -- mod-version:3
    local lspconfig = require "plugins.lsp.config"

    lspconfig.${name}.setup {
      command = { "${pkgs.rust-analyzer}/bin/rust-analyzer" }
    }
    ' > $out/share/${name}_lsp.lua
  '';
}

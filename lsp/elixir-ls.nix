{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "elixirls";
  src = null;

  phases = ["installPhase"];

  installPhase = ''
    mkdir -p $out/share

    echo '
    -- mod-version:3
    local lspconfig = require "plugins.lsp.config"

    lspconfig.${name}.setup {
      command = { "${pkgs.elixir-ls}/bin/elixir-ls" }
    }
    ' > $out/share/${name}_lsp.lua
  '';
}

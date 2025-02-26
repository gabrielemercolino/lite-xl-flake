{pkgs}: {
  autoinsert = pkgs.callPackage ./autoinsert.nix {};
  lsp = pkgs.callPackage ./lsp.nix {};
}

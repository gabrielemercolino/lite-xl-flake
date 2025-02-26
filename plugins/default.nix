{pkgs}: {
  autoinsert = pkgs.callPackage ./autoinsert.nix {};
  code-plus = pkgs.callPackage ./code-plus.nix {};
  colorpreview = pkgs.callPackage ./colorpreview.nix {};
  console = pkgs.callPackage ./console.nix {};
  lsp = pkgs.callPackage ./lsp.nix {};
  widgets = pkgs.callPackage ./widgets.nix {};
}

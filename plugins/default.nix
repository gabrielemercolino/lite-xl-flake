{pkgs}: {
  autoinsert = pkgs.callPackage ./autoinsert.nix {};
  code-plus = pkgs.callPackage ./code-plus.nix {};
  colorpreview = pkgs.callPackage ./colorpreview.nix {};
  console = pkgs.callPackage ./console.nix {};
  gitblame = pkgs.callPackage ./gitblame.nix {};
  gitdiff_highlight = pkgs.callPackage ./gitdiff_highlight.nix {};
  gitstatus = pkgs.callPackage ./gitstatus.nix {};
  lintplus = pkgs.callPackage ./lintplus.nix {};
  lsp = pkgs.callPackage ./lsp.nix {};
  widgets = pkgs.callPackage ./widgets.nix {};
}

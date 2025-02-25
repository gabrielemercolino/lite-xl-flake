{pkgs}: {
  elixir-ls = pkgs.callPackage ./elixir-ls.nix {};
  nil = pkgs.callPackage ./nil.nix {};
  rust_analyzer = pkgs.callPackage ./rust_analizer.nix {};
}

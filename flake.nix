{
  description = "template dev flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    overlay = final: prev: {
      lite-xl-plugins = final.callPackage ./plugins {};
      lite-xl-lsp = final.callPackage ./lsp {};
    };

    packages.${system} = {
      lite-xl-plugins = pkgs.callPackage ./plugins {};
      lite-xl-lsp = pkgs.callPackage ./lsp {};
    };

    homeManagerModules = {
      lite-xl = import ./module.nix;
      default = self.homeManagerModules.lite-xl;
    };
  };
}

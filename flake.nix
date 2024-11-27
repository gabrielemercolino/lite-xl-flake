{
  description = "template dev flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      overlay = final: prev: {
        lite-xl-extensions = final.callPackage ./lite-xl-extensions.nix { };
        lite-xl-lsp = pkgs.callPackage ./lite-xl-lsp.nix { };
      };

      packages.${system} = {
        lite-xl-extensions = pkgs.callPackage ./lite-xl-extensions.nix { };
        lite-xl-lsp = pkgs.callPackage ./lite-xl-lsp.nix { };
      };

      homeManagerModules = {
        lite-xl =
          { config, pkgs, ... }:
          {
            imports = [
              ./module.nix
            ];
          };
        default = self.homeManagerModules.lite-xl;
      };
    };
}

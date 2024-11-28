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
        lite-xl-plugins = final.callPackage ./extensions.nix { };
        lite-xl-lsp = pkgs.callPackage ./lspServers.nix { };
      };

      packages.${system} = {
        lite-xl-plugins = pkgs.callPackage ./extensions.nix { };
        lite-xl-lsp = pkgs.callPackage ./lspServers.nix { };
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

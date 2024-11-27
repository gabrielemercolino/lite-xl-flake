{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.lite-xl;

  generateExtensions =
    exts:
    builtins.foldl' (
      acc: ext:
      let
        directory = ext.passthru.targetDir;
      in
      acc
      // {
        ${directory} = {
          source = "${ext}/share/${ext.name}";
          recursive = true;
        };
      }
    ) { } exts;

  generateLspServers =
    servers:
    builtins.foldl' (
      acc: lspServer:
      let
        fileName = "lite-xl/plugins/${lspServer.name}_lsp.lua";
      in
      acc
      // {
        ${fileName} = {
          source = "${lspServer}/share/${lspServer.name}_lsp.lua";
        };
      }
    ) { } servers;
in
{
  options.programs.lite-xl = {
    enable = lib.mkEnableOption "lite-xl";

    extensions = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = with pkgs.lite-xl-extensions; [
        lsp
        widgets
      ];
      description = "The extensions to add";
    };

    lspServers = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = with pkgs.lite-xl-lsp; [ rust_analyzer ];
      description = "The lsp servers to add";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.lite-xl ];

    xdg.configFile = lib.mkMerge [
      (generateExtensions cfg.extensions)
      (generateLspServers cfg.lspServers)
    ];

  };

}

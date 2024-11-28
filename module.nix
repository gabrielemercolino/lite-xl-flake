{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.lite-xl;

  generatePlugins =
    plugins:
    builtins.foldl' (
      acc: plugin:
      let
        directory = plugin.passthru.targetDir;
      in
      acc
      // {
        ${directory} = {
          source = "${plugin}/share/${plugin.name}";
          recursive = true;
        };
      }
    ) { } plugins;

  generateLspServers =
    lspServers:
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
    ) { } lspServers;
in
{
  options.programs.lite-xl = {
    enable = lib.mkEnableOption "lite-xl";

    plugins = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = with pkgs.lite-xl-plugins; [
        lsp
        widgets
      ];
      description = "The plugins to add";
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
      (generatePlugins cfg.plugins)
      (generateLspServers cfg.lspServers)
    ];

  };

}

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.lite-xl;

  syntaxes = pkgs.callPackage ./syntaxes.nix { };

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

  generateSyntaxes =
    syntaxes:
    builtins.foldl' (
      acc: syntax:
      let
        fileName = "lite-xl/plugins/${syntax.name}_syntax.lua";
      in
      acc
      // {
        ${fileName} = {
          source = "${syntax}/share/${syntax.name}_syntax.lua";
        };
      }
    ) { } syntaxes;

  generateConfig = extraConfig: {
    "lite-xl/init.lua" = {
      text = extraConfig;
    };
  };
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

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = '''';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.lite-xl ];

    xdg.configFile = lib.mkMerge [
      (generatePlugins cfg.plugins)
      (generateLspServers cfg.lspServers)
      (generateSyntaxes syntaxes)
      (generateConfig cfg.extraConfig)
    ];

  };

}

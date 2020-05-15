{ config, lib, pkgs, ... }:
let
  cfg = config.programs.termonad;
in
with lib;
{
  options = {
    programs.termonad = {
      enable = mkEnableOption "Termonad";
      configuration = mkOption {
        type = types.str;
        default = "";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.termonad-with-packages;
      };
    };
  };

  config = mkIf cfg.enable (
    mkMerge [
      {
        home.packages = [ cfg.package ];
        home.file.".local/share/applications/termonad.desktop".text = ''
          [Desktop Entry]
          Encoding=UTF-8
          Version=3.1.0.0
          Type=Application
          Terminal=false
          Exec=${cfg.package}/bin/termonad
          Name=Termonad
          Icon=${builtins.fetchTarball https://github.com/cdepillabout/termonad/archive/082b75b55ec7277dde3533a1ec3285c2ce04cc6b.tar.gz}/img/termonad-lambda.png
        '';
      }
      (mkIf (cfg.configuration != "") {
        home.file.".config/termonad/termonad.hs".text = cfg.configuration;
      })
    ]
  );
}

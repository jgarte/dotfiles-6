{ config, lib, pkgs, ... }:
let
  cfg = config.roboto-fonts;
in
with lib;
{
  options = {
    roboto-fonts = {
      enable = mkEnableOption "Roboto fonts";
    };
  };

  config = mkIf cfg.enable (
    if builtins.currentSystem == "x86_64-darwin" then {
      home.file."Library/Fonts/roboto" = {
        source = pkgs.roboto;
        recursive = true;
      };
      home.file."Library/Fonts/roboto-mono" = {
        source = pkgs.roboto-mono;
        recursive = true;
      };
    } else {
      home.file.".fonts/roboto" = {
        source = pkgs.roboto;
      };
      home.file.".fonts/roboto-mono" = {
        source = pkgs.roboto-mono;
      };
    }
  );
}

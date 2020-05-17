{ config, lib, pkgs, ... }:
let
  cfg = config.programs.termonad;
in
with lib;
{
  options = {
    powerline-fonts = {
      enable = mkEnableOption "Powerline fonts";
    };
  };

  config = mkIf cfg.enable (
    if builtins.currentSystem == "x86_64-darwin" then {
      home.file."Library/fonts/powerline-fonts" = {
        source = pkgs.powerline-fonts;
      };
    } else {
      home.file.".fonts/powerline-fonts" = {
        source = pkgs.powerline-fonts;
      };
    }
  );
}

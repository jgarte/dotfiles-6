{ config, lib, pkgs, ... }:
let
  cfg = config.programs.firefox-with-desktop-entry;
  firefox = pkgs.firefox;
in
with lib;
{
  options = {
    programs.firefox-with-desktop-entry = {
      enable = mkEnableOption "Firefox with desktop entry";
    };
  };

  config = mkIf cfg.enable ({
    programs.firefox = {
      enable = true;
      package = firefox;
      profiles.brad = {
        id = 0;
        isDefault = true;
        settings = {
          "font.name.monospace.x-western" = "Roboto Mono";
          "font.name.sans-serif.x-western" = "Roboto";
          "font.name.serif.x-western" = "serif";
          "font.size.monospace.x-western" = "16";
        };
      };
    };
    home.file.".local/share/applications/firefox.desktop".source = "${firefox}/share/applications/firefox.desktop";
  });
}

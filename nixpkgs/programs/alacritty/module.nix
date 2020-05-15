{ config, lib, pkgs, ... }:
let
  cfg = config.programs.cross-platform-alacritty;
in
with lib;
{
  options = {
    programs.cross-platform-alacritty = {
      enable = mkEnableOption "Alacritty";

      settings = mkOption {
        type = types.attrs;
        default = { };
        example = literalExample ''
          {
            window.dimensions = {
              lines = 3;
              columns = 200;
            };
            key_bindings = [
              {
                key = "K";
                mods = "Control";
                chars = "\\x0c";
              }
            ];
          }
        '';
        description = ''
          Configuration written to
          <filename>~/.config/alacritty/alacritty.yml</filename>. See
          <link xlink:href="https://github.com/jwilm/alacritty/blob/master/alacritty.yml"/>
          for the default configuration.
        '';
      };
    };
  };

  config = mkIf cfg.enable (
    mkMerge [
      {
        xdg.configFile."alacritty/alacritty.yml" = mkIf (cfg.settings != { }) {
          text =
            replaceStrings [ "\\\\" ] [ "\\" ] (builtins.toJSON cfg.settings);
        };
      }
      (mkIf (builtins.currentSystem != "x86_64-darwin") {
        home.packages = [ pkgs.alacritty ];
      })
      (mkIf (builtins.currentSystem == "x86_64-darwin") {
        home.file."Applications/Alacritty.app" = {
          source = "${pkgs.alacritty}/Applications/Alacritty.app";
          recursive = true;
        };
      })
    ]
  );
}

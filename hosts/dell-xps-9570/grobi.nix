{ pkgs, ... }:
{
  services.grobi = {
    enable = true;
    rules = [
      {
        name = "docked";
        outputs_connected = [ "eDP-1" "DP-1-3" ];
        atomic = true;
        configure_row = [ "eDP-1" "DP-1-1" ];
        primary = "DP-1-3";
        execute_after = [
          "${pkgs.feh}/bin/feh --bg-fill ~/Pictures/Wallpapers/zelda_totk_left.png --bg-fill ~/Pictures/Wallpapers/zelda_totk_left.png"
        ];
      }
      {
        name = "undocked";
        outputs_disconnected = [ "DP-1-3" ];
        configure_single = "eDP-1";
        primary = true;
        atomic = true;
        execute_after = [
          "${pkgs.feh}/bin/feh --bg-fill ~/Pictures/Wallpapers/zelda_totk_left.png"
        ];
      }
      {
        name = "fallback";
        configure_single = "eDP-1";
      }
    ];
  };
}

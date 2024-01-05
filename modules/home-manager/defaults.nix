{ pkgs, lib, ... }:

{
  # Allow un-free packages
  nixpkgs.config.allowUnfree = true;

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 10;
      selection.save_to_clipboard = true;
    };
  };

  programs.git = {
    enable = true;
    userEmail = "jtfidje@gmail.com";
    userName = "Jahn Thomas Fidje";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      mhutchie.git-graph
      bbenoist.nix
      pkief.material-icon-theme
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-theme-onedark";
        publisher = "akamud";
        version = "2.3.0";
        sha256 = "1km3hznw8k0jk9sp3r81c89fxa311lc6gw20fqikd899pvhayqgh";
      }
      {
        name = "ruff";
        publisher = "charliermarsh";
        version = "2023.60.0";
        sha256 = "qgwud2gzHLHID45VxDlngFMoks5O3pTHQe+Q7bdf8+I=";
      }
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = "Atom One Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "[python]" = {
        "editor.rulers" = [88];
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
    };
  };

  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun";
      show-icons = true;
    };
    theme = ../../configurations/rofi/theme.rasi;
  };

  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    opacityRules = [
      "90:class_g = 'Alacritty' && focused"
      "80:class_g = 'Alacritty' && !focused"
    ];
    settings = {
      corner-radius = 5;
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = let
      mod = "Mod4";
    in {
      modifier = mod;
      terminal = "alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun";
      
      gaps.inner = 8;
      gaps.outer = 2;

      startup = [
        {
          command = "nm-applet";
          always = false;
          notification = false;
        }
        {
          command = "feh --bg-scale ~/.background-image";
          always = true;
          notification = false;
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${mod}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
        "${mod}+Shift+f" = "exec flameshot gui";
        "${mod}+Shift+e" = "exec xfce-session-logout";
      };

      colors = {
        focusedInactive = {
          border = "#333333";
          background = "#222222";
          text = "#ffffff";
          indicator = "#484e50";
          childBorder = "#222222";
        };
      };

      bars = [
        {
          command = "i3bar --transparency";
          statusCommand = "${pkgs.i3blocks}/bin/i3blocks";
          position = "bottom";
          colors = {
            background = "#111111BC";
            focusedWorkspace = {
              background = "#040404";
              border = "#2C2C34";
              text = "#ffffff";
            };
          };
        }
      ];
    };

    extraConfig = ''
        # Remove titlebars, keep window border
        default_border pixel 1
      '';

  };
}
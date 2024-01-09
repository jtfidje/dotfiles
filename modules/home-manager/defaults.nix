{ pkgs, lib, ... }:

{
  # Allow un-free packages
  nixpkgs.config.allowUnfree = true;

  # Configure bash
  programs.bash = 
    let
      gitAware = builtins.fetchGit
        {
          url = "https://github.com/jimeh/git-aware-prompt";
          ref = "master";
          rev = "df8f218d4af51b1fac03f58bf0ddc776466312de";
        };
    in
    {
      enable = true;
      bashrcExtra = ''
        export GITAWAREPROMPT=${gitAware.outPath}
        source "${gitAware.outPath}/main.sh"
        export PS1="\[\]\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\[\033[0m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
      '';
   };

  # Configure Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;
    };
  };

  # Configure Git
  programs.git = {
    enable = true;
    userEmail = "jtfidje@gmail.com";
    userName = "Jahn Thomas Fidje";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Configure VSCode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      mhutchie.git-graph
      bbenoist.nix
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "easy-icons";
        publisher = "jamesmaj";
        version = "0.3.1";
        sha256 = "RKVK9bNbv9gjhbbN4gPWAzysAx8BuY2HD8wfwjloYyY=";
      }
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
      "workbench.iconTheme" = "easy-icons";
      "[python]" = {
        "editor.rulers" = [88];
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
    };
  };

  # Configure Rofi
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun";
      show-icons = true;
    };
    theme = ../../configurations/rofi/theme.rasi;
  };

  # Configure Picom
  services.picom = {
    enable = true;
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

  # Configure i3
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

      defaultWorkspace = "workspace number 1";

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
        "${mod}+Shift+e" = "exec xfce4-session-logout";
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
              text = "#C5C8C6";
            };
          };
          fonts = {
            names = [ "DejaVu Sans Mono" ];
            size = 10.0;
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

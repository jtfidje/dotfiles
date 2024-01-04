{ pkgs, ... }:

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
}
{ pkgs, ... }:

{
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

  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    opacityRules = [
      "90:class_g = 'Alacritty' && focused"
      "80:class_g = 'Alacritty' && !focused"
    ];
    settings.corner-radius = 5;
    shadow = true;
    shadowOpacity = 0.75;
  };
}
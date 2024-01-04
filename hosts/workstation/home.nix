{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/defaults.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jtfidje";
  home.homeDirectory = "/home/jtfidje";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jtfidje/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Configure Picom
  services.picom = {
    settings = {
      vsync = true;
      unredir-if-possible = false;
    };
  };

  # Download wallpaper
  home.file.".background-image".source = pkgs.fetchurl {
    url = "https://uccd7e53115c13be07a08af5c035.previews.dropboxusercontent.com/p/thumb/ACK5HN0lKJK-NAa_lkSwrz--ysMp9AW8cZuDCB4EGZvWnw8PM6bjG-GCjV7-9lqpiEJvaNnwOFnzwQZAQRXuFMeo8jDAQj4JxO5Y5TMgdIotiSeSgI9bTt2haEpWylof25-ljqV2mbu2zXlLl_8vZiO8aL959mznnjavojt7FhbdjtEseiA1LIJEq3y4J_Wdix5q-Rpz5kxKxk-ownG4t-4ywFNSnWzsxElc_m_wvc-EpJwj_pvT-TO_iL3cnqFu3Y5bcF1B1GA0MM-FiVASJb8iujdNFa20FwNyJ9FfrmMH-Hra4UTnBrzkw8szjJQipbkyRTD0-xCDO0AUuzGDWvAgD8evJF98yg2B9xkUx9u3Qfw4DI2HiKkrm41GNdIgdFg/p.jpeg";
    sha256 = "11si7irrng3ijvvjh4zv888w4fhzg6hqjb7j97lzqq5gd4favla3";
  };

  # Configure Alacritty
  programs.alacritty = {
    settings = {
      colors.primary.background = "#111111";
    };
  };
}

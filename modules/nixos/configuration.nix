
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    layout = "no";
    xkbVariant = "";
    libinput.enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };


    displayManager = {
      gdm.enable = true;
      gdm.wayland = false;
      defaultSession = "xfce+i3";
    };

    windowManager = {
      i3 = {
        enable = true;
      };
    };
  };
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with PulseAudio.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   wireplumber.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   jack.enable = true;
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jtfidje = {
    isNormalUser = true;
    description = "Jahn Thomas Fidje";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [
      bitwarden
      discord
      flameshot
      insync
      obsidian
      poppler_utils
      slack
      spotify
    ];
  };

  fonts.packages = with pkgs; [
    font-awesome
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    feh
    firefox
    i3blocks
    lxappearance
    pavucontrol
    poetry
    pulseaudio  # Installs pulse tools, but does not enable it as a backend
    pyenv
    python3
    tmux
    vim
    wget
  ];

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable Firmware Update daemon
  services.fwupd.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  boot.loader.systemd-boot.configurationLimit = 10;

  # Allow insecure packages:
  #   - electron-25.9.0
  #     - obsidian
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}

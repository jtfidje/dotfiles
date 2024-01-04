{ config, pkgs, ... }:

{
  # Set some boot-params
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  # Patches for Hyprland with nVidia cards
  # environment.sessionVariables = {
    # If your cursor becomes invisible
    # WLR_NO_HARDWARE_CURSORS = "1";
    
    # Hint electron apps to use Wayland
    # NIXOS_OZONE_WL = "1";
  # };

  # Enable OpenGL 
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # nVidia Settings
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}

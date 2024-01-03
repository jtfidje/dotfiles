{ config, lib, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "i915" ];
  boot.extraModprobeConfig = ''
    options i915 enable_fbc=1 disable_power_well=0 fastboot=1 enable_psr=0
  '';

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl.extraPackages = with pkgs; [
    (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then vaapiIntel else intel-vaapi-driver)
    libvdpau-va-gl
    intel-media-driver
  ];
}
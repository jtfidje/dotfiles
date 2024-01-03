# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "i915" ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [
    "mem_sleep_default=deep"
    "acpi_rev_override=1"
    "acpi_osi=Linux"
    "pcie_aspm=force"
    "drm.vblankoffdelay=1"
    "nmi_watchdog=0"
  ];

  boot.blacklistedKernelModules = [ "nouveau" "rivafb" "nvidiafb" "rivatv" "nv" ];
  boot.extraModprobeConfig = ''
    options i915 enable_fbc=1 disable_power_well=0 fastboot=1 enable_psr=0
  '';

  hardware.nvidia = {
    powerManagement.finegrained = false; # Not applicable - GPU too old
    open = false; # Not applicable - GPU too old 

    powerManagement.enable = false;  # Experimental. Can cause sleep/suspend to fail

    prime.sync.enable = true;
    prime.intelBusId = "PCI:0:2:0";
    prime.nvidiaBusId = "PCI:1:0:0";
  };


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8a2cebb4-ab1e-4c84-b9fe-a8608b2f3a2c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/900B-AE4A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp59s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

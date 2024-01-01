###############################
## Dell XPS 15 9570 (0x087C) ##
###############################

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/configuration.nix
      ../../modules/nixos/nvidia.nix
      inputs.home-manager.nixosModules.default
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" "i915" ];
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

  users.users.jtfidje.extraGroups = [ "video" ];
  programs.light.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jtfidje" = import ./home.nix;
    };
  };
}

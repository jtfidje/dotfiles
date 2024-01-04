######################################
## Workstation AMD 7950x / RTX 4090 ##
######################################

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/configuration.nix
      ../../modules/nixos/nvidia.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "mars"; # Define your hostname.

  hardware.nvidia = {
    open = true;
    powerManagement.finegrained = false; # Not applicable - Desktop
    powerManagement.enable = false;  # Not applicable - Desktop
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jtfidje" = import ./home.nix;
    };
  };

  boot.kernelParams = [ 
    "pcie_port_pm=off"
    "pcie_aspm.policy=performance"
  ];
}

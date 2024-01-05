######################################
## Workstation AMD 7950x / RTX 4090 ##
######################################

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  virtualisation.vmware.guest.enable = true;

  networking.hostName = "vm"; # Define your hostname.

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jtfidje" = import ./home.nix;
    };
  };
}

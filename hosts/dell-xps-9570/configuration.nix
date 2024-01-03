###############################
## Dell XPS 15 9570 (0x087C) ##
###############################

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./intel-gpu.nix
      ../../modules/nixos/configuration.nix
      ../../modules/nixos/nvidia-disable.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "gastly"; # Define your hostname.

  users.users.jtfidje.extraGroups = [ "video" ];
  programs.light.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jtfidje" = import ./home.nix;
    };
  };
}

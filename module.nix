# module.nix
{ config, pkgs, lib, ... }:

{
  # Boot loader configuration for DigitalOcean
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  # Root filesystem configuration
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  # Enable the Nginx web server
  services.nginx = {
    enable = true;
    # Tell Nginx to serve the files from our "www" directory
    virtualHosts."_".locations."/".root = ./www;
  };

  # Open port 80 (HTTP) in the server's firewall
  networking.firewall.allowedTCPPorts = [ 80 ];

  # Ensure SSH is enabled
  services.openssh.enable = true;

  # Set the system state version. This is important for
  # managing upgrades. We'll use 23.11, a recent stable version.
  system.stateVersion = "23.11";
}

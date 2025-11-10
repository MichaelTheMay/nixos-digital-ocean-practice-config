# flake.nix
{
  description = "My DigitalOcean NixOS Server";

  # We tell Nix where to get all its packages from
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  # This is the "output" of our project
  outputs = { self, nixpkgs }: {

    # We define one "NixOS System"
    # We're calling it "default"
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {

      # We specify the architecture for the DigitalOcean Droplet
      system = "x86_64-linux";

      # This is the magic: we include our module.nix file
      # which contains all our web server settings.
      modules = [
        ./module.nix
      ];
    };
  };
}

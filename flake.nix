{
  description = "sabisho's NixOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # === Global Configuration ===
    username = "sabisho";
    stateVersion = "26.05";
    system = "x86_64-linux";

    # === System Configurations ===
    # Add or modify systems here
    systems = {
      Athena = {
        hostname = "Athena";
        type = "laptop";
        profile = "nvidia-prime";
      };

      Aeirith = {
        hostname = "Aeirith";
        type = "desktop";
        profile = "nvidia";
      };
    };

    # === Build System Function ===
    mkSystem = {
      hostname,
      type,
      profile,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs username stateVersion hostname profile type;
        };

        modules = [
          # System configuration
          ./hosts/${type}/${hostname}/configuration.nix

          # Hardware/driver profile
          ./modules/drivers/${profile}.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hmbak";
              users.${username} = import ./modules/home/home.nix;
              extraSpecialArgs = {inherit inputs username stateVersion hostname type;};
            };
          }
        ];
      };
  in {
    # === Build all systems defined above ===
    nixosConfigurations = builtins.mapAttrs (name: config: mkSystem config) systems;
  };
}

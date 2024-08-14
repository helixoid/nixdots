{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:{
    nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
	 system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
        modules = [
          ./nixos/configuration.nix
          # home-manager.nixosModules.home-manager
          # {
          #    home-manager.extraSpecialArgs = {
          #       inherit username;
          #       inherit inputs;
          #       inherit hostname;
          #     };
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.$(username) = import ./home-manager/home.nix;
        ];
          };
        };
  };
}

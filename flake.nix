{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
{
    nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
	 system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
        modules = [
          ./nixos/configuration.nix
	homeConfigurations = {
      # FIXME replace with your username@hostname
      "helix@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
        ];
          };
        };
  };
}

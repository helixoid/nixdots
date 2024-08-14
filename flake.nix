{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
	  ];
     	};
    };
  };
}

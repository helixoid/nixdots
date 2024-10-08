{
  description = "Your new nix config";

  inputs = {
    	# Nixpkgs
    	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	# home-manager = {
	#      		url = "github:nix-community/home-manager";
	#      		inputs.nixpkgs.follows = "nixpkgs";
	#    	};
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  {
    nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
	 system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
	  modules = [
          ./nixos/configuration.nix
	#   home-manager.nixosModules.home-manager
	#          {
	#            home-manager.useGlobalPkgs = true;
	#            home-manager.useUserPackages = true;
	#            home-manager.users.helix = import ./home-manager/home.nix;
	# }
	  ];
     	};
    };
  };
}

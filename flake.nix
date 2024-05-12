# /etc/nixos/flake.nix
{
  description = "flake config";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixvim,
    home-manager,
  }: {
    nixosConfigurations = {
      timeless = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/timeless/timeless.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.sergio = import ./home/home.nix;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
      gyroscope = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/gyroscope/gyroscope.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.sergio = import ./home/home.nix;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    };
  };
}

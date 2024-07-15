{
  description = "My NixOS and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mozilla = {
      url= "github:mozilla/nixpkgs-mozilla";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      extraSpecialArgs = { inherit inputs; };
    in {
    nixosConfigurations = {
      pc = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration-pc.nix
          home-manager.nixosModules.home-manager
          {
            home-manager ={
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.alex = import ./home-manager/home.nix;
            };
          }
        ];
      };
      mac = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./nixos/configuration-mac.nix
          home-manager.nixosModules.home-manager
          {
            home-manager ={
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.alex = import ./home-manager/home.nix;
            };
          }
        ];
      };
    };
  };
}

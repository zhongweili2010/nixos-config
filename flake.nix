{
  description = "My NixOS and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration-pc.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alex = import ./home-manager/home.nix;
          }
        ];
      };
      mac = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./nixos/configuration-mac.nix
          {
            nixpkgs.overlays=[(import ./overlays/mozilla-overlay.nix)];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alex = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}

{
  description = "A very basic flake";
inputs = {

  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
};
  outputs = { self, nixpkgs }: {
    nixosConfigurations.StinkPadX13 = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}

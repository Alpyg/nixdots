{ self, inputs, ... }:
{
  flake.nixosConfigurations.yutu = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.yutuConfiguration
      self.nixosModules.yutuHardware
      self.nixosModules.yutuUsers

      # self.nixosModules.stylix

      inputs.home-manager.nixosModules.default
      # inputs.stylix.nixosModules.stylix
      inputs.sops-nix.nixosModules.sops
    ];
  };

  flake.nixosModules.yutuUsers =
    { pkgs, ... }:
    {
      users.users.alpyg = {
        isNormalUser = true;
        shell = pkgs.fish;
      };
      home-manager.users.alpyg = self.homeModules.alpyg;
    };
}

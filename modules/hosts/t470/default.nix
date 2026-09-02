{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.t470 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.t470Configuration
      self.nixosModules.t470Hardware
      self.nixosModules.t470Users

      self.nixosModules.tailscale
      # self.nixosModules.stylix

      inputs.nur.modules.nixos.default
      inputs.home-manager.nixosModules.default
      # inputs.stylix.nixosModules.stylix
      inputs.sops-nix.nixosModules.sops
    ];
  };

  flake.nixosModules.t470Users = {pkgs, ...}: {
    users.users.t470 = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "storage"
        "docker"
      ];
    };
    home-manager.users.t470 = self.homeModules.t470;
  };
}

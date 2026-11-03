{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nexus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.base
      self.nixosModules.nexusConfiguration
      self.nixosModules.nexusHardware
      self.nixosModules.nexusUsers

      self.nixosModules.stylix

      inputs.home-manager.nixosModules.default
      inputs.sops.nixosModules.sops
    ];
  };

  flake.nixosModules.nexusUsers = {pkgs, ...}: {
    users.users.nexus = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "storage"
      ];
    };
    home-manager.users.nexus = self.homeModules.nexus;
  };
}

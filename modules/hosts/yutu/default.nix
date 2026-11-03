{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.yutu = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.base
      self.nixosModules.yutuConfiguration
      self.nixosModules.yutuHardware
      self.nixosModules.yutuUsers

      self.nixosModules.noctalia

      self.nixosModules.stylix

      inputs.nur.modules.nixos.default
      inputs.home-manager.nixosModules.default
      inputs.sops.nixosModules.sops
      inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
    ];
  };

  flake.nixosModules.yutuUsers = {pkgs, ...}: {
    users.users.alpyg = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "storage"
      ];
    };
    home-manager.users.alpyg = self.homeModules.alpyg;
  };
}

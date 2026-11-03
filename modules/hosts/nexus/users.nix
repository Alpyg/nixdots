{
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations.nexus = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.nexus
    ];
  };

  flake.homeModules.nexus = {pkgs, ...}: {
    imports = [
      self.homeModules.base
      self.homeModules.stylix
    ];

    home = {
      username = "nexus";
      homeDirectory = "/home/nexus";
    };

    programs.home-manager.enable = true;
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    home.packages = with pkgs; [
      p7zip
      unzip
      sops
      inputs.nvf.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}

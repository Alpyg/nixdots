{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.yutu = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.yutuConfiguration
      self.nixosModules.yutuHardware
      self.nixosModules.yutuUsers

      self.nixosModules.tailscale
      # self.nixosModules.stylix

      inputs.nur.modules.nixos.default
      inputs.home-manager.nixosModules.default
      # inputs.stylix.nixosModules.stylix
      inputs.sops-nix.nixosModules.sops
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
        "docker"
      ];
    };
    home-manager.users.alpyg = self.homeModules.alpyg;

    users.users.dokploy = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = ["docker"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAkiR3D1WKlLwI91cOfK/ETYl8PAYgjCmoZsAi/33r4U dokploy"
      ];
    };

    environment.systemPackages = with pkgs; [
      git
      git-lfs
      jq
      openssl
      unzip
      uutils-tar
      wget
    ];

    systemd.tmpfiles.rules = [
      "d /etc/dokploy 0755 dokploy dokploy -"
    ];
  };
}

{...}: {
  flake.nixosModules.nexusConfiguration = {
    pkgs,
    config,
    lib,
    ...
  }: {
    sops.age.keyFile = "/home/nexus/.config/sops/age/keys.txt";
    nix.settings.trusted-users = ["nexus"];
    networking.hostName = "nexus";
  };
}

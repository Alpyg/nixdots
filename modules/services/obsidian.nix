{...}: {
  flake.nixosModules.obsidian = {
    config,
    pkgs,
    ...
  }: let
    port = 60002;
  in {
    services.traefik.routes = [
      {
        name = "obsidian";
        domain = "obsidian.alpyg.dev";
        port = port;
      }
    ];
    virtualisation.oci-containers.backend = "podman";

    sops.secrets."obsidian/env".owner = "root";
    virtualisation.oci-containers.containers.obsidian = {
      image = "docker.io/oleduc/docker-obsidian-livesync-couchdb:latest";
      ports = ["${toString port}:5984"];
      environmentFiles = [config.sops.secrets."obsidian/env".path];
      environment = {
        SERVER_DOMAIN = "obsidian.alpyg.dev";
        COUCHDB_USER = "alpyg";
        COUCHDB_DATABASE = "obsidian";
      };
      volumes = ["/var/lib/obsidian:/opt/couchdb/data"];
    };
  };
}

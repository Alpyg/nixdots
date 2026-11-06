{...}: {
  flake.nixosModules.vaultwarden = {pkgs, ...}: let
    port = 60001;
  in {
    services.traefik.routes = [
      {
        name = "vaultwarden";
        domain = "vaultwarden.alpyg.dev";
        port = 60001;
        certResolver = "letsencrypt";
      }
    ];
    services.vaultwarden = {
      enable = true;
      config = {
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = port;
        DOMAIN = "https://vaultwarden.alpyg.dev";
        SIGNUPS_ALLOWED = false;
      };
    };
  };
}

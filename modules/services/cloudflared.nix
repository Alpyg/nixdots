{...}: {
  flake.nixosModules.cloudflared = {config, ...}: {
    sops.secrets."cloudflared/tunnel" = {owner = "nexus";};
    services.cloudflared = {
      enable = true;
      tunnels = {
        "nexus-traefik" = {
          credentialsFile = config.sops.secrets."cloudflared/tunnel".path;
          ingress = {
            "*.alpyg.dev" = "http://127.0.0.1:80";
          };
          default = "http_status:404";
        };
      };
    };
  };
}

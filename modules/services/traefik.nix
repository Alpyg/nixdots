{...}: {
  flake.nixosModules.traefik = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) listToAttrs nameValuePair mkOption types;

    cfg = config.services.traefik;

    mkRoutes = routes: let
      toRouter = r: let
        resolver = r.certResolver or "letsencrypt";
      in
        nameValuePair "${r.name}-router" (
          {
            rule = "Host(`${r.domain}`)";
            entryPoints = [
              (
                if resolver != null
                then "websecure"
                else "web"
              )
            ];
            service = "${r.name}-service";
          }
          // lib.optionalAttrs (resolver != null) {tls.certResolver = resolver;}
        );

      toService = r:
        nameValuePair "${r.name}-service" {
          loadBalancer.servers = [
            {
              url =
                if r.address != null
                then r.address
                else "http://127.0.0.1:${toString r.port}";
            }
          ];
        };
    in {
      http.routers = listToAttrs (map toRouter routes);
      http.services = listToAttrs (map toService routes);
    };
  in {
    options.services.traefik.routes = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {type = types.str;};
          domain = mkOption {type = types.str;};
          port = mkOption {
            type = types.port;
            default = null;
          };
          address = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "http://ip:port";
          };
          certResolver = mkOption {
            type = types.nullOr (types.enum ["letsencrypt"]);
            default = null;
            description = "'letsencrypt' or null";
          };
        };
      });
      default = [];
      description = "Traefik routers/services to generate.";
    };

    config = {
      _module.args.mkRoutes = mkRoutes;

      sops.secrets."traefik/env".owner = "traefik";
      services.traefik = {
        enable = true;

        environmentFiles = [config.sops.secrets."traefik/env".path];

        staticConfigOptions = {
          entryPoints = {
            web = {
              address = ":80";
              asDefault = true;
            };

            websecure = {
              address = ":443";
              asDefault = true;
              http.tls.certResolver = "letsencrypt";
            };
          };

          api = {
            dashboard = true;
            insecure = false;
          };

          log = {
            level = "INFO";
            filePath = "${config.services.traefik.dataDir}/traefik.log";
            format = "json";
          };

          certificatesResolvers.letsencrypt.acme = {
            email = "postmaster@alpyg.dev";
            storage = "${config.services.traefik.dataDir}/acme.json";
            dnsChallenge = {
              provider = "cloudflare";
              resolvers = ["1.1.1.1:53" "8.8.8.8:53"];
            };
          };
        };

        dynamicConfigOptions = mkRoutes cfg.routes;
      };
    };
  };
}

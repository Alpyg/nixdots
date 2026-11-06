{...}: {
  flake.nixosModules.kavita = {
    config,
    pkgs,
    ...
  }: let
    port = 60003;
  in {
    services.traefik.routes = [
      {
        name = "kavita";
        domain = "kavita.alpyg.dev";
        port = port;
      }
    ];

    sops.secrets."kavita/token".owner = "kavita";
    services.kavita = {
      enable = true;
      settings = {
        IpAddresses = "0.0.0.0";
        Port = port;
      };

      tokenKeyFile = config.sops.secrets."kavita/token".path;
    };
  };
}

{...}: {
  flake.nixosModules.adguard = {pkgs, ...}: let
    port = 60000;
  in {
    services.traefik.routes = [
      {
        name = "adguard";
        domain = "adguard.alpyg.dev";
        port = port;
        certResolver = "letsencrypt";
      }
    ];
    services.adguardhome = {
      enable = true;

      settings = {
        http.address = "0.0.0.0:${toString port}";
        http.session_ttl = "30d";

        users = [
          {
            name = "alpyg";
            password = "$2a$10$8iWxAPf.4x3lHNi.nRPN4OBsj3m2aPMVtcvBpokgBNy2F2xKCNAOi";
          }
        ];

        auth_attempts = 5;

        dns = {
          bind_hosts = ["0.0.0.0"];
          port = 53;
          upstream_dns = [
            "9.9.9.9"
            "149.112.112.112"
          ];
        };
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
          parental_enabled = false;
          safe_search.enabled = false;
        };
        filters =
          map (f: {
            enabled = true;
            url = f.url;
            name = f.name;
          }) [
            {
              name = "AdGuard DNS filter";
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
            }
            {
              name = "AdAway Default Blocklist";
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
            }
            {
              name = "The Big List of Hacked Malware Web Sites";
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt";
            }
            {
              name = "Malicious URL Blocklist (URLHaus)";
              url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt";
            }
          ];
      };
    };
  };
}

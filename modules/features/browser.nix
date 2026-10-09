{inputs, ...}: {
  flake.homeModules.browser = {
    pkgs,
    config,
    ...
  }: {
    nixpkgs.overlays = [inputs.firefox-addons.overlays.default];

    programs.zen-browser = {
      enable = true;
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles."Alpyg" = {
        id = 0;
        settings = {
          "zen.workspaces.continue-where-left-off" = true;
          "zen.workspaces.natural-scroll" = true;
          "zen.view.compact.hide-tabbar" = true;
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.animate-sidebar" = true;
          "zen.welcome-screen.seen" = true;
        };
        presets.catppuccin.enable = true;
        mods = [
          "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24"
          "81fcd6b3-f014-4796-988f-6c3cb3874db8"
          "1e86cf37-a127-4f24-b919-d265b5ce29a0"
          "4596d8f9-f0b7-4aeb-aa92-851222dc1888"
        ];
        extensions.packages = with pkgs.firefox-addons; [
          bitwarden-password-manager
          jisho-kioku
          jisho-lookup
          jisho-ojad
          proton-vpn
          sponsorblock
          styl-us
          tampermonkey
          temp-mail
          ublock-origin
          yomitan
          youtube-auto-hd-fps
          youtube-row-fixer-extension
        ];

        search = {
          default = "google";
          privateDefault = "brave";

          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };
          };
        };
      };
    };

    programs.firefox = {
      enable = true;

      policies = {
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;

        DisableBuiltinPDFViewer = true;
        DisableFirefoxStudies = true;
        DisableForgetButton = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableRemoteImrpvements = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;

        # Access Restrictions
        BlockAboutConfig = false;
        BlockAboutProfiles = false;
        BlockAboutSupport = true;

        # UI and Behavior
        DisplayMenuBar = "never";
        DontCheckDefaultBrowser = true;
        HardwareAcceleration = true;
        OfferToSaveLogins = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          SuspectedFingerprinting = true;
        };

        DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
      };

      profiles."Alpyg" = {
        extensions.packages = with pkgs.firefox-addons; [
          bitwarden-password-manager
          jisho-kioku
          jisho-lookup
          jisho-ojad
          proton-vpn
          sponsorblock
          styl-us
          tampermonkey
          temp-mail
          ublock-origin
          yomitan
          youtube-auto-hd-fps
          youtube-row-fixer-extension
        ];

        settings = {
          "browser.nova.enabled" = false;
        };

        search = {
          default = "google";
          privateDefault = "brave";

          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };
          };
        };
      };
    };
  };
}

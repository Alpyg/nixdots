{ self, inputs, ... }:
{
  flake.homeConfigurations.alpyg = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.alpyg
    ];
  };

  flake.homeModules.alpyg =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        self.homeModules.base
        self.homeModules.hyprland
        # self.homeModules.stylix
        self.homeModules.dev

        inputs.stylix.homeModules.stylix
        inputs.zen-browser.homeModules.beta
      ];

      nixpkgs = {
        overlays = [
          # (final: prev: {
          #   hi = final.hello.overrideAttrs (oldAttrs: {
          #     patches = [ ./change-hello-to-hi.patch ];
          #   });
          # })
        ];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };

      home = {
        username = "alpyg";
        homeDirectory = "/home/alpyg";
      };

      programs.home-manager.enable = true;
      programs.obs-studio.enable = true;
      programs.fish.enable = true;
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

      services.kdeconnect.enable = true;
      services.hyprpolkitagent.enable = true;

      home.packages = with pkgs; [
        zoxide
        nixfmt
        tmuxinator
        libnotify
        xclip
        flameshot
        playerctl
        catppuccin-fcitx5
        p7zip
        unzip
        unrar
        thunderbird
        brave
        vlc
        mpv
        syncplay
        calibre
        unityhub
        alcom
        goverlay
        prismlauncher
        osu-lazer
        obsidian
        prusa-slicer
        libsForQt5.qt5ct
        kdePackages.qt6ct
        kdePackages.breeze-gtk
        kdePackages.breeze-icons
        kdePackages.qtstyleplugin-kvantum
        kdePackages.kdegraphics-thumbnailers
        kdePackages.ffmpegthumbs
        kdePackages.qtimageformats
        kdePackages.qtsvg
        kdePackages.ark
        kdePackages.gwenview
        kdePackages.dolphin
        kdePackages.kate
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.filelight
        kdePackages.ktorrent
        kdePackages.kservice
        kdePackages.polkit-kde-agent-1
        wineWow64Packages.unstable
        (lutris.override {
          extraLibraries = pkgs: [
            wineWow64Packages.unstable
            libGL
          ];
        })
        protontricks
        steamtinkerlaunch
        winetricks
        limo
        lsfg-vk
        lsfg-vk-ui
        discord

        # stremio
        # kicad
        blender
        freecad
        sops
        anki
        gimp
        r2modman
        blockbench
        inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

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
          mods = [
            "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24"
            "81fcd6b3-f014-4796-988f-6c3cb3874db8"
            "1e86cf37-a127-4f24-b919-d265b5ce29a0"
            "4596d8f9-f0b7-4aeb-aa92-851222dc1888"
          ];
          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            bitwarden
            sponsorblock
            stylus
            ublock-origin
            yomitan
            youtube-auto-hd-fps
          ];
        };
      };

      xdg.mimeApps.defaultApplications = {
        "text/html" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/about" = "zen.desktop";
        "x-scheme-handler/unknown" = "zen.desktop";
      };
      xdg.configFile."menus/applications.menu".text =
        builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

      systemd.user.startServices = "sd-switch";

      home.stateVersion = "26.05";
    };
}

{
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations.alpyg = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.alpyg
    ];
  };

  flake.homeModules.alpyg = {pkgs, ...}: {
    imports = [
      self.homeModules.base
      self.homeModules.stylix
      self.homeModules.hyprland
      self.homeModules.browser
      self.homeModules.dev
      self.homeModules.nixcord
      self.homeModules.gaming
      # self.homeModules.llm

      inputs.stylix.homeModules.stylix
      inputs.nixcord.homeModules.nixcord
      inputs.zen-browser.homeModules.beta
    ];

    nixpkgs = {
      overlays = [
        inputs.nur.overlays.default
      ];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permittedInsecurePackages = [
          "electron-40.10.5"
        ];
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

      stremio-linux-shell
      kicad
      blender
      openscad
      # freecad
      sops
      anki
      gimp
      r2modman
      blockbench
      inputs.nvf.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.mimeApps.defaultApplications = {
      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop";
    };
    xdg.configFile."menus/applications.menu".text =
      builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
        };
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
          "org.freedesktop.impl.portal.OpenURI" = ["gtk"];
        };
      };
    };

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "26.05";
  };
}

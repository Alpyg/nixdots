{...}: {
  flake.nixosModules.t470Configuration = {
    pkgs,
    config,
    lib,
    ...
  }: {
    environment.variables.GLFW_IM_MODULE = "ibus";

    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = ["t470"];
    };
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    sops.defaultSopsFile = ../../../secrets.yml;
    sops.defaultSopsFormat = "yaml";

    sops.age.generateKey = true;
    sops.age.keyFile = "/home/alpyg/.config/sops/age/keys.txt";

    networking = {
      hostName = "t470";
      networkmanager.enable = true;
      firewall.enable = true;
    };
    services.openssh.enable = true;

    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
    hardware.bluetooth.enable = true;

    virtualisation.docker = {
      enable = true;
      liveRestore = false;
      extraOptions = "--insecure-registry nexus:5000";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    users.defaultUserShell = pkgs.fish;

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.package = pkgs.kdePackages.sddm;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "t470";
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    services.udisks2.enable = true;

    programs.fish.enable = true;
    programs.partition-manager.enable = true;

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraProfile = ''
          export PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc
          export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
          unset TZ
        '';
      };
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    environment.systemPackages = with pkgs; [
      fishPlugins.done
      kitty
      nix-index
      neovim
      stow
      gtk3
      dmenu
      killall
      vulkan-loader
      qpwgraph
      wget
      v4l-utils
      linuxPackages.v4l2loopback
      dconf
    ];
    environment.shells = with pkgs; [fish];

    environment = {
      variables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";
      };
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
        # QT_QPA_PLATFORMTHEME = "qt6ct";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        T_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        WLR_NO_HARDWARE_CURSORS = "1";
      };
    };

    fonts.packages = with pkgs; [nerd-fonts.noto];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        # inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
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

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    system.stateVersion = "26.05";
  };
}

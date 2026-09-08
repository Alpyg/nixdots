{...}: {
  flake.nixosModules.yutuConfiguration = {
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
      trusted-users = ["alpyg"];
    };
    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = ["ntfs"];

    sops.defaultSopsFile = ../../../secrets.yml;
    sops.defaultSopsFormat = "yaml";

    sops.age.generateKey = true;
    sops.age.keyFile = "/home/alpyg/.config/sops/age/keys.txt";

    networking = {
      hostName = "yutu";
      firewall = {
        enable = true;
        trustedInterfaces = [
          "eno1"
        ];
      };
    };

    services.openssh.enable = true;
    services.zerotierone = {
      enable = true;
      joinNetworks = ["743993800fb0301f"];
      localConf = {};
    };

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
    hardware.opentabletdriver.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    virtualisation.docker = {
      enable = true;
      liveRestore = false;
      extraOptions = "--insecure-registry nexus:5000";
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia-container-toolkit.enable = true;

    # virtualisation.virtualbox.host = {
    #   enable = true;
    #   enableKvm = true;
    #   addNetworkInterface = false;
    # };
    users.extraGroups.vboxusers.members = ["alpyg"];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.alpyg = {
      isNormalUser = true;
      description = "Alpyg";
      extraGroups = [
        "networkmanager"
        "wheel"
        "storage"
        "docker"
      ];
    };
    users.defaultUserShell = pkgs.fish;

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.package = pkgs.kdePackages.sddm;
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "alpyg";
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

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;

      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

    services.wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;

      package = pkgs.wivrn.override {config.cudaSupport = true;};

      config = {
        enable = true;
        json = {
          scale = 0.5;
          bitrate = 100000000;
          encoders = [
            {
              encoder = "nvenc";
              codec = "h264";
              width = 1.0;
              height = 1.0;
              offset_x = 0.0;
              offset_y = 0.0;
            }
          ];
          application = with pkgs; [wayvr];
        };
      };
    };
    systemd.user.services.wivrn.environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=%t/bus";

    # stylix = {
    #   enable = true;
    #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # };

    environment.systemPackages = with pkgs; [
      openvpn
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

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      glib
      libgcc
      libz
      libGL
      libX11
      libxcb
    ];

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

    services.samba = {
      enable = true;
      openFirewall = true;

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "disable netbios" = "yes";

          "interfaces" = "lo eno1";
          "bind interfaces only" = "yes";

          "security" = "user";
          "use sendfile" = "yes";
          "max protocol" = "smb3";
          "min protocol" = "smb2";
          "guest account" = "alpyg";
          "map to guest" = "bad user";
        };
        "Anime" = {
          "path" = "/mnt/y/.torrents/Anime";
          "browsable" = "yes";
          "read only" = "yes";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "alpyg";
          "valid users" = "alpyg";
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    services.transmission = {
      enable = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/mnt/y/.torrents";
        incomplete-dir-enabled = false;
      };
    };

    system.stateVersion = "26.05";
  };
}

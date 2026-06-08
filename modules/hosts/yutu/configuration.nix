{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.yutuConfiguration =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      # ollama.enable = true;

      environment.variables.GLFW_IM_MODULE = "ibus";

      nix.settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ "alpyg" ];
      };
      nixpkgs.config.allowUnfree = true;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.supportedFilesystems = [ "ntfs" ];

      sops.defaultSopsFile = ../../../secrets.yml;
      sops.defaultSopsFormat = "yaml";

      sops.age.generateKey = true;
      sops.age.keyFile = "/home/alpyg/.config/sops/age/keys.txt";

      networking = {
        hostName = "nixos";
        # useDHCP = true;
        firewall = {
          enable = true;
          trustedInterfaces = [
            "eno1"
            "zth6rflskm"
          ];
          allowedTCPPorts = [
            22
            9000
            9001
            9942
            9943
            9944
            11470
            25565
          ];
          allowedUDPPorts = [
            22
            9000
            9001
            9942
            9943
            9944
            11470
          ];
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          allowedUDPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
        };
      };

      services.openvpn.servers = {
        protonvpn.config = ''config /home/alpyg/.openvpn/protonvpn.ovpn'';
      };
      environment.etc."openvpn/update-resolv-conf".source =
        "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";

      services.openssh.enable = true;
      services.zerotierone = {
        enable = true;
        joinNetworks = [ "743993800fb0301f" ];
        localConf = { };
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
      services.xserver = {
        videoDrivers = [ "nvidia" ];

        config = ''
          Section "Device"
            Identifier    "Device0"
            Driver        "nvidia"
            VendorName    "NVIDIA Corporation"
            BoardName     "GeForce RTX 3060"
            Option        "Coolbits" "12"
            Option        "RegistryDwords" "PowerMizerEnable=0x1; PowerMizerDefaultAC=0x3;"
          EndSection
        '';
      };

      virtualisation.docker = {
        enable = true;
        liveRestore = false;
        extraOptions = "--insecure-registry 10.147.20.18:10000";
      };
      services.dockerRegistry = {
        enable = true;
        enableDelete = true;
        enableGarbageCollect = true;
        openFirewall = true;
        port = 10000;
        listenAddress = "0.0.0.0";
      };
      # hardware.nvidia-container-toolkit.enable = true;

      # virtualisation.virtualbox.host = {
      #   enable = true;
      #   enableKvm = true;
      #   addNetworkInterface = false;
      # };
      users.extraGroups.vboxusers.members = [ "alpyg" ];

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

      # services.xserver.windowManager.bspwm.enable = true;
      # services.picom.enable = true;
      # services.devmon.enable = true;
      # services.passSecretService.enable = true;
      # security.pam.services.login.enableKwallet = true;
      # security.polkit.enable = true;

      programs.fish.enable = true;
      programs.partition-manager.enable = true;

      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        package = pkgs.steam.override {
          extraProfile = ''
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
      # programs.alvr = {
      #   enable = true;
      #   openFirewall = true;
      # };
      programs.noisetorch.enable = true;
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

      #  services.wivrn = {
      #   enable = true;
      #   openFirewall = true;
      #   autoStart = true;

      #   package = pkgs.wivrn.override { config.cudaSupport = true; };

      #   config = {
      #     enable = true;
      #     json = {
      #       scale = 0.5;
      #       bitrate = 100000000;
      #       encoders = [{
      #         encoder = "nvenc";
      #         codec = "h264";
      #         width = 1.0;
      #         height = 1.0;
      #         offset_x = 0.0;
      #         offset_y = 0.0;
      #       }];
      #       application = [ pkgs.wlx-overlay-s ];
      #     };
      #   };
      # };

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
      environment.shells = with pkgs; [ fish ];
      environment.sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
        # QT_QPA_PLATFORMTHEME = "qt6ct";
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

      fonts.packages = with pkgs; [ nerd-fonts.noto ];

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        config = {
          common = {
            default = [
              "hyprland"
              "gtk"
            ];
          };
        };
      };

      systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
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
            "security" = "user";
            #"use sendfile" = "yes";
            #"max protocol" = "smb2";
            # note: localhost is the ipv6 localhost ::1
            "hosts allow" = "10.147.20.0/24 192.168.2.0/24 127.0.0.1 localhost";
            "hosts deny" = "0.0.0.0/0";
            "guest account" = "alpyg";
            "map to guest" = "bad user";
          };
          "laribi" = {
            "path" = "/mnt/y/.share/laribi";
            "browsable" = "yes";
            "read only" = "no";
            "guest ok" = "yes";
            "create mask" = "0644";
            "directory mask" = "0755";
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

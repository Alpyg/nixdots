{...}: {
  flake.nixosModules.base = {
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
    };
    nixpkgs.config.allowUnfree = true;

    networking = {
      nftables.enable = true;
      networkmanager.enable = true;
      firewall = {
        enable = true;
        trustedInterfaces = [config.services.tailscale.interfaceName];
        allowedUDPPorts = [config.services.tailscale.port];
      };
    };
    services.tailscale.enable = true;

    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = ["ntfs"];

    sops.defaultSopsFile = ./../../secrets.yml;
    sops.defaultSopsFormat = "yaml";
    sops.age.generateKey = true;

    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    services.openssh.enable = true;
    services.udisks2.enable = true;

    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_US.UTF-8";

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    fonts.packages = with pkgs; [nerd-fonts.noto];

    system.stateVersion = "26.05";
  };
}

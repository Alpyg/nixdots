{...}: {
  flake.nixosModules.t470Configuration = {
    pkgs,
    config,
    lib,
    ...
  }: {
    sops.age.keyFile = "/home/alpyg/.config/sops/age/keys.txt";
    nix.settings.trusted-users = ["alpyg"];
    networking.hostName = "t470";

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
  };
}

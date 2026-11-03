{...}: {
  flake.nixosModules.nexusHardware = {
    config,
    lib,
    disko,
    modulesPath,
    ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot.initrd.availableKernelModules = [
      "ahci"
      "usb_storage"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [""];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/27115c58-cdec-4add-aaf0-7b5004e78b08";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd"
      ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/27115c58-cdec-4add-aaf0-7b5004e78b08";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
      ];
    };

    fileSystems."/var" = {
      device = "/dev/disk/by-uuid/27115c58-cdec-4add-aaf0-7b5004e78b08";
      fsType = "btrfs";
      options = [
        "subvol=@var"
        "compress=zstd"
      ];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/27115c58-cdec-4add-aaf0-7b5004e78b08";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };

    fileSystems."/swap" = {
      device = "/dev/disk/by-uuid/27115c58-cdec-4add-aaf0-7b5004e78b08";
      fsType = "btrfs";
      options = [
        "subvol=@swap"
        "noatime"
      ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/76C6-7DA8";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      {
        device = "/swap/swapfile";
        size = 8 * 1024;
      }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

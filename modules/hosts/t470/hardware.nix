{...}: {
  flake.nixosModules.t470Hardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [""];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/f59dffca-afc6-4338-9ef2-c924337ba40d";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "compress=zstd"
      ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/f59dffca-afc6-4338-9ef2-c924337ba40d";
      fsType = "btrfs";
      options = [
        "subvol=@home"
        "compress=zstd"
      ];
    };

    fileSystems."/var" = {
      device = "/dev/disk/by-uuid/f59dffca-afc6-4338-9ef2-c924337ba40d";
      fsType = "btrfs";
      options = [
        "subvol=@var"
        "compress=zstd"
      ];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/f59dffca-afc6-4338-9ef2-c924337ba40d";
      fsType = "btrfs";
      options = [
        "subvol=@nix"
        "compress=zstd"
        "noatime"
      ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3022-8008";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    # swapDevices = [
    #   {
    #     device = "/swap/swapfile";
    #     size = 8 * 1024;
    #   }
    # ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

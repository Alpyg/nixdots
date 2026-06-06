{ self, inputs, ... }:
{
  flake.nixosModules.yutuHardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ "amdgpu" ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/f8658ba2-c23d-43dc-a4f6-2d0c25885cc8";
        fsType = "btrfs";
        options = [
          "subvol=@"
          "compress=zstd"
        ];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/f8658ba2-c23d-43dc-a4f6-2d0c25885cc8";
        fsType = "btrfs";
        options = [
          "subvol=@home"
          "compress=zstd"
        ];
      };

      fileSystems."/var" = {
        device = "/dev/disk/by-uuid/f8658ba2-c23d-43dc-a4f6-2d0c25885cc8";
        fsType = "btrfs";
        options = [
          "subvol=@var"
          "compress=zstd"
        ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/f8658ba2-c23d-43dc-a4f6-2d0c25885cc8";
        fsType = "btrfs";
        options = [
          "subvol=@nix"
          "compress=zstd"
          "noatime"
        ];
      };

      fileSystems."/swap" = {
        device = "/dev/disk/by-uuid/f8658ba2-c23d-43dc-a4f6-2d0c25885cc8";
        fsType = "btrfs";
        options = [
          "subvol=@swap"
          "noatime"
        ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/8420-9B07";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/mnt/x" = {
        device = "/dev/disk/by-uuid/d7a408d4-44e1-4717-9385-494f15784a58";
        fsType = "ext4";
      };

      fileSystems."/mnt/y" = {
        device = "/dev/disk/by-uuid/bf9b64e3-b69d-4f00-8201-1b7237934366";
        fsType = "ext4";
      };

      swapDevices = [ { device = "/swap/swapfile"; } ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    };
}

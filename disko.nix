{
  disko.devices.disk.main = {
    device = "/dev/sda";
    type = "disk";

    content.type = "gpt";

    content.partitions.esp = {
      priority = 1;
      size = "512M";
      type = "EF00";
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
        mountOptions = ["fmask=0077" "dmask=0077"];
      };
    };

    content.partitions.root = {
      size = "100%";
      content = {
        type = "btrfs";
        extraArgs = ["-f"];
        subvolumes = {
          "@" = {
            mountpoint = "/";
            mountOptions = ["compress=zstd"];
          };
          "@home" = {
            mountpoint = "/home";
            mountOptions = ["compress=zstd"];
          };
          "@var" = {
            mountpoint = "/var";
            mountOptions = ["compress=zstd"];
          };
          "@nix" = {
            mountpoint = "/nix";
            mountOptions = ["compress=zstd" "noatime"];
          };
          "@swap" = {
            mountpoint = "/swap";
            mountOptions = ["noatime"];
            swap = {
              swapfile.size = "8G";
            };
          };
        };
      };
    };
  };
}

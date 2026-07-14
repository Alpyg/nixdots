{ lib, ... }:
{
  flake.homeModules.base =
    {
      pkgs,
      ...
    }:
    {
      programs.fish = {
        enable = true;
        shellAliases = {
          l = "ls -lah";
        };
      };

      programs.kitty = {
        enable = true;
        font.size = lib.mkForce 9;
      };

      programs.btop = {
        enable = true;
        package = pkgs.btop.overrideAttrs (old: rec {
          cudaSupport = true;
        });
        settings = {
          update_ms = 100;
          use_fstab = false;
          disks_filter = "/ /mnt/x /mnt/y /mnt/z";
        };
      };

      services.dunst.enable = true;

      home.packages = with pkgs; [
        mangohud
        dust
        dua
        eza
        fd
        lldb
        ripgrep-all
        # uutils-coreutils-noprefix
        xh
      ];

      home.shellAliases = {
        ls = "eza";
      };

      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batgrep
          batman
          batpipe
          batwatch
          prettybat
        ];
      };

      programs.yazi = {
        enable = true;
        settings.manager.show_hidden = true;
      };

      programs.helix = {
        enable = true;
        settings = {
          editor.cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };

      # programs.bat = {
      #   enable = true;
      #   extraPackages = with pkgs.bat-extras; [
      #     batdiff
      #     batgrep
      #     batman
      #     batpipe
      #     batwatch
      #     prettybat
      #   ];
      # };

      # programs.yazi = {
      #   enable = true;
      #   settings.manager.show_hidden = true;
      # };

      # programs.helix = {
      #   enable = true;
      #   settings = {
      #     editor.cursor-shape = {
      #       normal = "block";
      #       insert = "bar";
      #       select = "underline";
      #     };
      #   };
      # };
    };
}

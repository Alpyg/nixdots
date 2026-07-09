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
      xdg.configFile."MangoHud/MangoHud.conf".text = ''
        legacy_layout=false

        horizontal
        round_corners=10
        background_alpha=0.0
        background_color=1E1E2E
        table_columns=3

        font_size=16
        text_color=CDD6F4
        position=top-left

        toggle_hud=Shift_R+F1
        hud_compact

        gpu_stats
        gpu_text=GPU
        gpu_load_change
        gpu_load_value=50,90
        gpu_load_color=FFFFFF,FFAA7F,CC0000
        gpu_temp
        gpu_color=A6E3A1

        cpu_stats
        cpu_text=CPU
        cpu_load_change
        cpu_load_value=50,90
        cpu_load_color=FFFFFF,FFAA7F,CC0000
        cpu_temp
        cpu_color=89B4F4

        vram
        vram_color=AD64C1

        ram
        ram_color=F5C2E7

        fps
        frame_timing
        frametime_color=A6E3A1
        fps_limit_method=early
        toggle_fps_limit=none

        fps_limit=0
        fps_color_change
        fps_color=B22222,FDFD09,39F900
        fps_value=30,60
        #offset=0

        output_folder="/home/alpyg"
        toggle_logging=none
      '';

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

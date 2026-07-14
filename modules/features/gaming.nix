{ self, inputs, ... }:
{
  flake.homeModules.gaming =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        (lutris.override {
          extraLibraries = pkgs: [
            wineWow64Packages.unstable
            gamemode
            libGL
          ];
        })
        wineWow64Packages.unstable
        protontricks
        steamtinkerlaunch
        winetricks
        limo
        lsfg-vk
        lsfg-vk-ui
        protonup-rs
        uzdoom
        nur.repos.ataraxiasjel.stalker-gamma-cli
      ];

      xdg.configFile."MangoHud/MangoHud.conf".text = ''
        legacy_layout=false

        horizontal
        round_corners=10
        background_alpha=0.0
        background_color=1E1E2E
        table_columns=3

        font_size=12
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
    };
}

{inputs, ...}: {
  flake.homeModules.hyprland = {pkgs, ...}: {
    home.packages = with pkgs; [
      wofi
      grim
      slurp
      hyprshot
      clipse
      wl-clipboard
      wayvnc
    ];
    xdg.configFile = {
      "hypr/hyprsplit" = {
        source = "${
          inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplitlua
        }/share/hyprsplit";
        recursive = true;
      };
    };
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ../../config/hyprland/hyprland.lua;

      xwayland.enable = true;
    };
  };
}

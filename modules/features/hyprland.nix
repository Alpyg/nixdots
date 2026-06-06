{ self, inputs, ... }:
{
  flake.homeModules.hyprland =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        wofi
        grim
        slurp
        hyprshot
        clipse
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
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        extraConfig = builtins.readFile ../../config/hyprland/hyprland.lua;
      };
    };
}

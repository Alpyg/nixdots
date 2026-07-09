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
    };
}

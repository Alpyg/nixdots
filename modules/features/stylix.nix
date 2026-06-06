{ self, inputs, ... }:
{
  flake.nixosModules.stylix =
    { pkgs, ... }:
    {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      };
    };

  flake.homeModules.stylix =
    { pkgs, ... }:
    {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

        cursor = {
          package = pkgs.catppuccin-cursors;
          name = "mochaBlue";
          size = 24;
        };

        fonts.sizes = {
          applications = 10;
          desktop = 10;
        };

        targets = {
          zen-browser.profileNames = [ "Alpyg" ];
        };

      };
    };
}

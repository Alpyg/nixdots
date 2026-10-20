{...}: {
  flake.nixosModules.stylix = {pkgs, ...}: {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      targets = {
        chromium.enable = true;
      };
    };

    programs.chromium.enable = true;
  };

  flake.homeModules.stylix = {pkgs, ...}: {
    stylix = {
      fonts.sizes = {
        applications = 9;
        desktop = 9;
      };

      targets = {
        zellij.enable = true;
        nixcord.enable = false;
        firefox.profileNames = ["Alpyg"];
        zen-browser.profileNames = ["Alpyg"];
      };
    };
  };
}

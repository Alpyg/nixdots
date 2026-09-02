{inputs, ...}: {
  flake.homeModules.browser = {pkgs, ...}: {
    programs.zen-browser = {
      enable = true;
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles."Alpyg" = {
        id = 0;
        settings = {
          "zen.workspaces.continue-where-left-off" = true;
          "zen.workspaces.natural-scroll" = true;
          "zen.view.compact.hide-tabbar" = true;
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.animate-sidebar" = true;
          "zen.welcome-screen.seen" = true;
        };
        mods = [
          "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24"
          "81fcd6b3-f014-4796-988f-6c3cb3874db8"
          "1e86cf37-a127-4f24-b919-d265b5ce29a0"
          "4596d8f9-f0b7-4aeb-aa92-851222dc1888"
        ];
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          bitwarden
          sponsorblock
          stylus
          ublock-origin
          yomitan
          youtube-auto-hd-fps
        ];
      };
    };
  };
}

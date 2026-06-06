{ self, inputs, ... }:
{
  flake.homeModules.nixcord =
    { pkgs, ... }:
    {
      programs.nixcord = {
        enable = true;
        discord.vencord.enable = true;
        legcord = {
          enable = true;
          vencord.enable = true;
        };
        config = {
          enabledThemeLinks = [ "https://github.com/catppuccin/discord/blob/main/themes/mocha.theme.css" ];
          frameless = true;
          plugins = {
            betterFolders.enable = true;
            betterRoleContext.enable = true;
            betterRoleDot.enable = true;
            callTimer.enable = true;
            clearUrls.enable = true;
            crashHandler.enable = true;
            fakeNitro.enable = true;
            imageZoom = {
              enable = true;
              zoom = 3.0;
              size = 700.0;
            };
            memberCount.enable = true;
            messageLogger = {
              enable = true;
              ignoreSelf = true;
              ignoreBots = true;
            };
            PinDMs.enable = true;
            silentTyping.enable = true;
            typingIndicator.enable = true;
          };
        };
      };
    };
}

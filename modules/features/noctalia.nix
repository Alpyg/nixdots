{
  inputs,
  lib,
  ...
}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    imports = [
      inputs.umbriel.nixosModules.default
      inputs.noctalia.nixosModules.default
    ];

    services.displayManager.noctalia-greeter.enable = true;
    programs.umbriel.enable = true;
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true;
    };
  };

  flake.homeModules.noctalia = {pkgs, ...}: {
    imports = [
      inputs.umbriel.homeModules.default
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      settings = lib.mkForce (builtins.fromTOML (builtins.readFile ../../config/noctalia/noctalia.toml));
    };

    programs.umbriel = {
      enable = true;
      settings = {
        general = {
          autostart = ["noctalia"];
          mod_key = "Super";
          xwayland = true;
          xwayland_native_resolution = false;
          show_cheatsheet = true;
          focus_on_activate = false;
          honor_restored_maximize = false;
        };
        output = {
          "LG Electronics 24MP56 0x0003A568" = {
            mode = "1920x1080@60";
            position = [0 0];
            cyclic_workspaces = true;
            workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
          };
          "LG Electronics 24MP56 0x00059A54" = {
            mode = "1920x1080@60";
            position = [1920 0];
            cyclic_workspaces = true;
            workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
          };
        };

        layout = {
          mode = "dwindle";
          gap = 4;
        };

        input = {
          keyboard = {
            layout = "us";
          };
        };

        keybinds = {
          "Mod+D" = "spawn:noctalia msg panel-toggle launcher";
          "Mod+Return" = "spawn:kitty";

          "Mod+X" = "window-close";
          "Mod+I" = "overview-toggle";

          "Mod+Left" = "window-focus-or-output-left";
          "Mod+Down" = "window-focus-or-output-down";
          "Mod+Up" = "window-focus-or-output-up";
          "Mod+Right" = "window-focus-or-output-right";

          "Mod+H" = "window-focus-or-output-left";
          "Mod+J" = "window-focus-or-output-down";
          "Mod+K" = "window-focus-or-output-up";
          "Mod+L" = "window-focus-or-output-right";

          "Mod+Shift+Left" = "column-move-left";
          "Mod+Shift+Down" = "window-move-or-output-down";
          "Mod+Shift+Up" = "window-move-or-output-up";
          "Mod+Shift+Right" = "column-move-right";

          "Mod+Shift+H" = "column-move-left";
          "Mod+Shift+J" = "window-move-or-output-down";
          "Mod+Shift+K" = "window-move-or-output-up";
          "Mod+Shift+L" = "column-move-right";

          "Mod+WheelUp" = "window-focus-or-output-left";
          "Mod+WheelDown" = "window-focus-or-output-right";
          "Mod+Shift+WheelUp" = "column-move-left";
          "Mod+Shift+WheelDown" = "column-move-right";

          "Mod+T" = {
            action = "window-toggle-floating";
            repeat = false;
          };
          "Mod+Shift+T" = {
            action = "window-focus-switch-floating";
            repeat = false;
          };
          "Mod+P" = {
            action = "window-toggle-pinned";
            repeat = false;
          };
          "Mod+M" = {
            action = "window-toggle-maximize-to-edges";
            repeat = false;
          };
          "Mod+F" = {
            action = "window-toggle-fullscreen";
            repeat = false;
          };

          "XF86AudioRaiseVolume" = {
            action = "spawn:noctalia msg volume-up";
            allow_when_locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = "spawn:noctalia msg volume-down";
            allow_when_locked = true;
          };
          "XF86AudioMute" = {
            action = "spawn:noctalia msg volume-mute";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioPlay" = {
            action = "spawn:noctalia msg media toggle";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioNext" = {
            action = "spawn:noctalia msg media next";
            allow_when_locked = true;
          };
          "XF86AudioPrev" = {
            action = "spawn:noctalia msg media previous";
            allow_when_locked = true;
          };
          "XF86MonBrightnessUp" = {
            action = "spawn:noctalia msg brightness-up";
            allow_when_locked = true;
          };
          "XF86MonBrightnessDown" = {
            action = "spawn:noctalia msg brightness-down";
            allow_when_locked = true;
          };

          "Mod+1" = "workspace-switch:1";
          "Mod+2" = "workspace-switch:2";
          "Mod+3" = "workspace-switch:3";
          "Mod+4" = "workspace-switch:4";
          "Mod+5" = "workspace-switch:5";
          "Mod+6" = "workspace-switch:6";
          "Mod+7" = "workspace-switch:7";
          "Mod+8" = "workspace-switch:8";
          "Mod+9" = "workspace-switch:9";
          "Mod+0" = "workspace-switch:10";
          "Mod+Shift+1" = "window-move-to-workspace:1";
          "Mod+Shift+2" = "window-move-to-workspace:2";
          "Mod+Shift+3" = "window-move-to-workspace:3";
          "Mod+Shift+4" = "window-move-to-workspace:4";
          "Mod+Shift+5" = "window-move-to-workspace:5";
          "Mod+Shift+6" = "window-move-to-workspace:6";
          "Mod+Shift+7" = "window-move-to-workspace:7";
          "Mod+Shift+8" = "window-move-to-workspace:8";
          "Mod+Shift+9" = "window-move-to-workspace:9";
          "Mod+Shift+0" = "window-move-to-workspace:10";
        };
      };
    };
  };
}

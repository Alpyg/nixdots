{ self, inputs, ... }:
{
  flake.homeModules.dev =
    {
      pkgs,
      ...
    }:
    {
      programs.git = {
        enable = true;
        lfs.enable = true;

        settings = {
          user.name = "Alpyg";
          user.email = "alpyg@pm.me";
          init.defaultBranch = "main";
        };
      };
      programs.gh.enable = true;
      programs.lazygit.enable = true;
      programs.direnv = {
        enable = true;
        # enableFishIntegration = true;
        nix-direnv.enable = true;
      };

      programs.tmux.enable = true;
      programs.tmux.mouse = true;
      programs.tmux.baseIndex = 1;

      programs.devenv = {
        enable = true;
        enableFishIntegration = true;
      };

      home.packages = with pkgs; [
        # bun
        # dbeaver-bin
        # dotnet-sdk
        # gcc
        # gnumake
        # go
        # godot_4
        lazydocker
        libnotify
        mask
        # mprocs
        # nixfmt
        # hyperfine
        # rustup
        # rusty-man
        tokei
        # vrc-get
        # zig
        # zls
        # renderdoc
        watchexec
        typst

        # language servers
        # csharp-ls
        # docker-language-server
        # fish-lsp
        # gopls
        # jdt-language-server
        # kotlin-language-server
        # libclang
        # marksman
        # nixd
        # omnisharp-roslyn
        # ruff
        # typescript-language-server
        # wgsl-analyzer
        # yaml-language-server
      ];
    };
}

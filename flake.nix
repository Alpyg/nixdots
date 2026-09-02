{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    sops-nix.url = "github:Mic92/sops-nix";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprsplit.url = "github:shezdy/hyprsplit";
    stylix.url = "github:nix-community/stylix";
    nvf.url = "github:Alpyg/nvf";
    nixcord.url = "github:FlameFlag/nixcord";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    vortex-nix.url = "github:crowquillx/vortex-nix";
  };

  nixConfig = {
    extra-substituters = ["https://vortex-nix.cachix.org"];
    extra-trusted-public-keys = [
      "vortex-nix.cachix.org-1:7+ZVU0umNp8sz1JqZV/bRcbVgemNuNtzN5KiJxihFRY="
    ];
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}

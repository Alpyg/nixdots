{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    sops.url = "github:Mic92/sops-nix";

    stylix.url = "github:nix-community/stylix";

    hyprsplit.url = "github:shezdy/hyprsplit";

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    nur.url = "github:nix-community/NUR";

    nvf.url = "github:Alpyg/nvf";
    nixcord.url = "github:FlameFlag/nixcord";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    firefox-addons.url = "github:petrkozorezov/firefox-addons-nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}

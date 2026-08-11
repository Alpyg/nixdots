{...}: {
  flake.homeModules.llm = {pkgs, ...}: let
    llama-cpp = pkgs.llama-cpp.override {
      cudaSupport = true;
    };
  in {
    home.packages = [
      llama-cpp
    ];
  };
}

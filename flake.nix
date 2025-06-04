{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      overlay = final: prev: {
        blender = prev.blender.override {
          cudaSupport = true;
        };
        obs-studio = prev.obs-studio.override {
          cudaSupport = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay ];
      };
    in
    {
      overlays.default = overlay;
      packages.${system} = {
        blender = pkgs.blender;
        obs-studio = pkgs.obs-studio;
      };
    };
}

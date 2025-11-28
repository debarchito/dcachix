{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    { ... }@inputs:
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
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ overlay ];
      };
    in
    {
      overlays.default = overlay;
      packages.${system} = {
        inherit (pkgs) blender obs-studio;
      };
    };
}

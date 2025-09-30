{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    jj = {
      url = "github:jj-vcs/jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    starship-jj = {
      url = "gitlab:lanastara_foss/starship-jj";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickemu = {
      url = "github:quickemu-project/quickemu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
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
        jujutsu = inputs.jj.packages.${system}.default;
        starship-jj = inputs.starship-jj.packages.${system}.default;
        quickemu = inputs.quickemu.packages.${system}.default;
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
        inherit (pkgs)
          blender
          obs-studio
          jujutsu
          starship-jj
          quickemu
          ;
      };
    };
}

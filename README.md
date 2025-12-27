## 1. What is this repo about?

This repo builds and caches these packages with optional custom overrides:

- **Blender** (CUDA + OptiX support)
- **OBS Studio** (CUDA support for hardware encoding i.e. NVENC)
- **starship-jj** (from [source](https://gitlab.com/lanastara_foss/starship-jj))

Caches are only available for `x86_64-linux`.

## 2. Cachix

Add the Cachix substituter for binary caches:

```nix
# configuration.nix
nix.settings = {
  substituters = [ "https://debarchito.cachix.org" ];
  trusted-public-keys = [ "debarchito.cachix.org-1:md/bk3JZDoFjVOa6bsIDqaY5hcSec4KPWn8q3PbpCl8=" ];
};
```

## 3. Flakes

Here is an example `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    dcachix.url = "github:debarchito/dcachix";
  };
  outputs = { nixpkgs, dcachix, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; # As CUDA is unfree
      overlays = [ dcachix.overlays.default ]
    };
  in
    {
      # Use "pkgs.blender" or "pkgs.obs-studio" as you usually would.
      # If you don't want to use the overlay, you can always:
      # dcachix.packages.${system}.<pkg-name>
    };
}
```

## 4. Run directly

You can always run the binaries directly using:

```nix
nix run github:debarchito/dcachix#<pkg-name>
```

## 5. License

This repository is licensed under the [Zlib](/LICENSE) license.

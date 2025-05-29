## What is this repo about?

This repo holds a Nix flake that builds packages I need with specific overrides
and uploads them to my Cachix cache; saving my precious little laptop CPU and
thermals.

Currently, it builds:

- Blender (CUDA support w/o breaking Vulkan experiments)
- OBS Studio (CUDA support for hardware encoding i.e. NVENC)

I only plan to support the latest version of these packages available in the
`nixos-unstable` channel for `x86_64-linux`. I will not provide caches for any
old versions.

## Cachix

Add the Cachix substituter for binary caches:

```nix
# configuration.nix
nix.settings = {
  substituters = [ "https://debarchito.cachix.org" ];
  trusted-public-keys = [ "debarchito.cachix.org-1:b9I9LSdMFockuXyfljPeoIcJtIVopf9rVkvkIG20PGg=" ];
};
```

## Flakes

```nix
# flake.nix
{
  inputs.debarchito-cachix.url = "github:debarchito/cachix";
  outputs = { debarchito-cachix, ... }: {
    # debarchito-cachix.packages.x86_64-linux.<pkg>;
    # where pkg = blender | obs-studio
  };
}
```

## License

[MIT](/LICENSE)

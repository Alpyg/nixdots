## update

> Update lock file

```sh
nix flake update
```

## cg

> Collect Garbage

```sh
sudo nix-collect-garbage -d
nix-collect-garbage -d
```

## test

> Runs `nixos-rebuild test` for .#yutu

```sh
nixos-rebuild test   --target-host root@10.147.20.18  --flake .#yutu
```

## switch (host)

> Runs `nixos-rebuild switch` for the specified host

```sh
nixos-rebuild switch --target-host root@$host --use-substitutes --flake .#$host
```

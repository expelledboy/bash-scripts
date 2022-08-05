# Bash Scripts

Useful bash scripts, that make writing bash bearable.

### Available Scripts

> TODO: Generate from `./bin/*` files

```
> assert-env-exists MY_ENV_VAR
+error: MY_ENV_VAR is not set in the environment
```

### Nix Flake

This was my first attempt at creating a nix flake.

Include it in your `flake.nix` as follows:

```nix
{
  inputs.bash-scripts.url = "github:expelledboy/bash-scripts";
}
```

### Reference Material

- [Understanding nix flakes](https://serokell.io/blog/practical-nix-flakes)
- [Flake for scripts](https://www.ertt.ca/nix/shell-scripts/)
- [Packaging like NUR](https://github.com/nix-community/nur-packages-template)
- [Existing scripts as package](https://discourse.nixos.org/t/basic-flake-run-existing-python-bash-script/19886/5)
- [Nix library reference](https://teu5us.github.io/nix-lib.html)
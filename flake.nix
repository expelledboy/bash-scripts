{
  description = "Useful scripts for writing simple bash";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachSystem [ "aarch64-darwin" ] (system:
      let

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ devshell.overlay ];
        };

        binFiles = builtins.attrNames (builtins.readDir ./bin);
        createScript = fileName: pkgs.writeScriptBin fileName ''
          #!${pkgs.stdenv.shell}
          ${builtins.readFile ./bin/${fileName}}
        '';
        scripts = map createScript binFiles;

        # TODO: These should be installed in my dotfiles.
        packages = with pkgs; [
          rnix-lsp
          nixpkgs-fmt
        ];

        # TODO: The command spec could be more simple.
        # commands = {
        #   "category" = {
        #     "cmd" = "echo command";
        #   };
        # };
        commands = [
          { category = "package"; name = "build"; command = "nix build"; }
          { category = "package"; name = "info"; command = "nix flake metadata && nix flake show"; }
          { category = "package"; name = "update-deps"; command = "nix flake update && direnv reload"; }
          { category = "source"; name = "format"; command = "nixpkgs-fmt **/*.nix"; }
        ];

      in
      {
        devShell = pkgs.devshell.mkShell {
          inherit commands;
          packages = packages ++ scripts;
        };
        packages.${system} = {
          inherit scripts;
        };
        checks = {
          build = self.devShell.${system};
        };
      });
}

# Reference Material
# - https://github.com/CaptainSpof/random-ramble/blob/main/flake.nix
# - https://github.com/hasktorch/libtorch-nix/blob/main/flake.nix
# - https://numtide.github.io/devshell/getting_started.html

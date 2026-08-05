{
  description = "Home Manager configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        config,
        lib,
        withSystem,
        ...
      }:
      let
        mkHome =
          pkgs:
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
          };
      in
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          inputs.treefmt-nix.flakeModule
        ];

        systems = [
          "aarch64-linux"
          "x86_64-linux"
        ];

        perSystem =
          { system, config, ... }:
          let
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfreePredicate = p: builtins.elem (lib.getName p) [ "1password-cli" ];
            };
          in
          {
            packages.default = (mkHome pkgs).activationPackage;

            packages.bootstrap-ssh = pkgs.writeShellApplication {
              name = "bootstrap-ssh";
              runtimeInputs = [
                pkgs._1password-cli
                pkgs.jq
              ];
              text = builtins.readFile ./scripts/bootstrap-ssh.sh;
            };

            apps.bootstrap-ssh = {
              type = "app";
              program = "${config.packages.bootstrap-ssh}/bin/bootstrap-ssh";
            };

            treefmt = {
              projectRootFile = "flake.nix";
              programs.nixfmt.enable = true;
            };
          };

        flake.homeConfigurations = lib.listToAttrs (
          map (system: {
            name = "matthew_deville@${system}";
            value = withSystem system ({ pkgs, ... }: mkHome pkgs);
          }) config.systems
        );
      }
    );
}

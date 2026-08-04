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
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];

        perSystem =
          { pkgs, ... }:
          {
            packages.default = (mkHome pkgs).activationPackage;

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
